/**
 * Build intelligent — ne reconstruit que les decks modifiés.
 *
 * Cache : .build-cache.json (SHA-256 des fichiers source)
 * Usage : node scripts/build-all.mjs [--force]
 */

import { execSync } from 'node:child_process'
import {
  cpSync, rmSync, existsSync,
  readFileSync, writeFileSync, mkdirSync
} from 'node:fs'
import { createHash } from 'node:crypto'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const force = process.argv.includes('--force')

// Load course config
const config = JSON.parse(readFileSync(resolve(root, 'course.config.json'), 'utf-8'))
const { decks } = config

// Load or init build cache
const cachePath = resolve(root, '.build-cache.json')
let cache = {}
if (!force && existsSync(cachePath)) {
  try { cache = JSON.parse(readFileSync(cachePath, 'utf-8')) } catch {}
}

function sha256(filePath) {
  try {
    return createHash('sha256').update(readFileSync(filePath)).digest('hex')
  } catch {
    return null
  }
}

function needsBuild(src, out) {
  if (force) return true
  const distDir = resolve(root, 'dist', out)
  if (!existsSync(distDir)) return true
  const current = sha256(resolve(root, src))
  return current !== cache[src]
}

const slidev = resolve(root, 'node_modules/.bin/slidev')

// Ensure dist and shared images exist
mkdirSync(resolve(root, 'dist'), { recursive: true })
const imagesSource = resolve(root, 'cours/public/images')
// Toujours rafraîchir : l'index pointe vers les corrigés dans dist/images,
// les slides vers les fichiers d'exercice dans dist/exercices
for (const dir of ['images', 'exercices']) {
  const source = resolve(root, 'cours/public', dir)
  if (!existsSync(source)) continue
  const dist = resolve(root, 'dist', dir)
  rmSync(dist, { recursive: true, force: true })
  cpSync(source, dist, { recursive: true })
}

let built = 0
let skipped = 0

for (const { src, out, exportWaitUntil } of decks) {
  if (!needsBuild(src, out)) {
    console.log(`⏭  Skipping ${src} (unchanged)`)
    skipped++
    continue
  }

  console.log(`\n📦 Building ${src} → dist/${out}`)
  execSync(
    `node ${slidev} build ${src} --base "/${out}/" --out ${resolve(root, 'dist', out)} --timeout 90000`,
    { stdio: 'inherit', cwd: root }
  )

  if (exportWaitUntil) {
    console.log(`📄 Exporting PDF for ${src} (--wait-until ${exportWaitUntil})`)
    execSync(
      `node ${slidev} export ${src} --output ${resolve(root, 'dist', out, 'slidev-exported.pdf')} --wait-until ${exportWaitUntil} --timeout 90000`,
      { stdio: 'inherit', cwd: root }
    )
  }

  // Ensure each deck has a real images dir : Render ne suit pas les liens symboliques
  const deckImages = resolve(root, 'dist', out, 'images')
  if (existsSync(imagesSource)) {
    rmSync(deckImages, { recursive: true, force: true })
    cpSync(imagesSource, deckImages, { recursive: true })
  }

  // Update cache after successful build
  cache[src] = sha256(resolve(root, src))
  built++
}

// Persist cache
writeFileSync(cachePath, JSON.stringify(cache, null, 2))

// Copy index page to dist root
const indexSrc = resolve(root, 'cours/public/index.html')
if (existsSync(indexSrc)) {
  cpSync(indexSrc, resolve(root, 'dist/index.html'))
}

console.log(`\n✅ Done — ${built} built, ${skipped} skipped.`)
