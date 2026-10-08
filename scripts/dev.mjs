/**
 * Lance le dev server Slidev pour un deck donné.
 * Usage : node scripts/dev.mjs [numéro ou slug]
 *   npm run dev        → liste les decks disponibles
 *   npm run dev -- 01  → ouvre le deck 01
 */

import { execSync } from 'node:child_process'
import { readFileSync, existsSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const config = JSON.parse(readFileSync(resolve(root, 'course.config.json'), 'utf-8'))
const { decks } = config

const arg = process.argv[2]

if (!arg) {
  console.log('\nDecks disponibles :')
  decks.forEach(({ src, out, title }, i) => {
    console.log(`  ${String(i + 1).padStart(2, '0')}  ${title.padEnd(30)} ${src}`)
  })
  console.log('\nUsage : npm run dev -- 01')
  process.exit(0)
}

// Match by index (01, 1, 2…) or by src slug
const idx = parseInt(arg, 10)
const deck =
  !isNaN(idx) && idx >= 1 && idx <= decks.length
    ? decks[idx - 1]
    : decks.find(d => d.out.startsWith(arg) || d.src.includes(arg))

if (!deck) {
  console.error(`Deck introuvable : "${arg}"`)
  process.exit(1)
}

const slidev = resolve(root, 'node_modules/.bin/slidev')
execSync(`node ${slidev} ${deck.src} --open`, { stdio: 'inherit', cwd: root })
