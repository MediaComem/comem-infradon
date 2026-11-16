#!/usr/bin/env node
// Exporte un fichier Markdown en PDF via pandoc (Markdown -> HTML autonome)
// puis Playwright/Chromium (HTML -> PDF, respecte les sauts de page CSS et
// ajoute un pied de page numéroté « page / total »).
//
// Usage : node scripts/export-pdf.mjs revisions/examen.md [revisions/examen.pdf]

import { execFileSync } from "node:child_process";
import { existsSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join, resolve, basename } from "node:path";
import { chromium } from "playwright-chromium";

// Regroupe chaque bloc délimité par une ligne `---` dans un conteneur
// `::: {.qblock}` (rendu en <div class="qblock">), pour qu'une question ne
// soit jamais coupée entre deux pages (cf. .qblock { page-break-inside: avoid }).
// Les lignes `---` situées à l'intérieur d'un bloc de code sont ignorées.
function wrapBlocks(md) {
  const lines = md.split("\n");
  const blocks = [];
  let current = [];
  let fence = null;
  for (const line of lines) {
    const t = line.trim();
    const m = t.match(/^(```+|~~~+)/);
    if (m) {
      if (!fence) fence = m[1][0];
      else if (t.startsWith(fence)) fence = null;
      current.push(line);
      continue;
    }
    if (!fence && t === "---") {
      blocks.push(current);
      current = [];
    } else {
      current.push(line);
    }
  }
  blocks.push(current);
  return blocks
    .map((b) => b.join("\n").trim())
    .filter((b) => b.length > 0)
    .map((b) => `::: {.qblock}\n\n${b}\n\n:::`)
    .join("\n\n---\n\n");
}

const input = process.argv[2];
if (!input) {
  console.error("Usage : node scripts/export-pdf.mjs <fichier.md> [sortie.pdf]");
  process.exit(1);
}

const inputPath = resolve(input);
if (!existsSync(inputPath)) {
  console.error(`Fichier introuvable : ${inputPath}`);
  process.exit(1);
}

const outputPath = resolve(
  process.argv[3] || inputPath.replace(/\.md$/i, ".pdf"),
);
const inputDir = dirname(inputPath);
const cssPath = join(inputDir, "print.css");

const tmp = mkdtempSync(join(tmpdir(), "pdf-export-"));
const htmlPath = join(tmp, "doc.html");
const preprocessedPath = join(tmp, "doc.md");

try {
  // 0. Prétraitement : grouper chaque question dans un bloc insécable.
  writeFileSync(preprocessedPath, wrapBlocks(readFileSync(inputPath, "utf8")));

  // 1. Markdown -> HTML autonome (image et CSS inlinés en base64).
  const pandocArgs = [
    preprocessedPath,
    "-o", htmlPath,
    // Autoriser une liste collée au paragraphe (pas de ligne vide requise),
    // pour rendre correctement les options des QCM.
    "-f", "markdown+lists_without_preceding_blankline",
    "--standalone",
    "--embed-resources",
    "--resource-path", inputDir,
    // pagetitle = balise <title> uniquement, sans titre visible dans le corps.
    "-V", `pagetitle=${basename(inputPath, ".md")}`,
  ];
  if (existsSync(cssPath)) pandocArgs.push("--css", cssPath);
  execFileSync("pandoc", pandocArgs, { stdio: "inherit" });

  // 2. HTML -> PDF via Playwright/Chromium, avec pied de page « page / total ».
  const browser = await chromium.launch({ args: ["--no-sandbox"] });
  try {
    const page = await browser.newPage();
    await page.goto(`file://${htmlPath}`, { waitUntil: "networkidle" });

    // 2a. Rendu des diagrammes Mermaid (s'il y en a).
    const mermaidCount = await page.evaluate(() => {
      let count = 0;
      document.querySelectorAll("pre").forEach((pre) => {
        const code = pre.querySelector("code");
        if (!code) return;
        const cls = `${pre.className} ${code.className}`;
        if (!cls.includes("mermaid")) return;
        const div = document.createElement("div");
        div.className = "mermaid";
        div.textContent = code.textContent;
        pre.replaceWith(div);
        count++;
      });
      return count;
    });

    if (mermaidCount > 0) {
      console.log(`  ${mermaidCount} diagramme(s) Mermaid…`);
      await page.addStyleTag({
        content: `
          .mermaid { text-align:center; margin:1rem 0;
                     page-break-inside:avoid; break-inside:avoid; }
          .mermaid svg { max-width:100% !important; height:auto !important; }`,
      });
      const cdnUrl =
        "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js";
      try {
        await page.addScriptTag({ url: cdnUrl });
      } catch {
        const js = await (await fetch(cdnUrl)).text();
        await page.addScriptTag({ content: js });
      }
      await page.waitForFunction(() => typeof mermaid !== "undefined", {
        timeout: 15000,
      });
      await page.evaluate(async () => {
        mermaid.initialize({ startOnLoad: false, theme: "neutral" });
        await mermaid.run({ querySelector: ".mermaid" });
      });
      await page.waitForSelector(".mermaid svg", { timeout: 10000 });
    }

    await page.pdf({
      path: outputPath,
      format: "A4",
      printBackground: true,
      margin: { top: "22mm", right: "18mm", bottom: "16mm", left: "18mm" },
      displayHeaderFooter: true,
      headerTemplate: /corrig/i.test(basename(inputPath))
        ? `<div style="width:100%; font-size:12px; color:#d6271e; font-weight:bold;
                       font-family:Helvetica,Arial,sans-serif;
                       padding:0 18mm; text-align:right;">CORRIGÉ</div>`
        : `<div style="width:100%; font-size:12px; color:#222;
                       font-family:Helvetica,Arial,sans-serif;
                       padding:0 18mm; text-align:right;">
             Nom :&nbsp;____________&nbsp;&nbsp; Prénom :&nbsp;____________&nbsp;&nbsp; Classe :&nbsp;________
           </div>`,
      footerTemplate: `
        <div style="width:100%; text-align:center; font-size:9px; color:#666;
                    font-family:Helvetica,Arial,sans-serif;">
          <span class="pageNumber"></span> / <span class="totalPages"></span>
        </div>`,
    });
  } finally {
    await browser.close();
  }

  console.log(`PDF généré : ${outputPath}`);
} finally {
  rmSync(tmp, { recursive: true, force: true });
}
