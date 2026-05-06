import { execSync } from 'node:child_process'
import { cpSync, rmSync, symlinkSync, existsSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..')

const decks = [
  { src: 'cours/01-introduction.md',                out: '01-introduction' },
  { src: 'cours/02-fondamentaux.md',                 out: '02-fondamentaux' },
  { src: 'cours/03-import-nettoyage.md',             out: '03-import-nettoyage' },
  { src: 'cours/04-transactions-concurrence.md',     out: '04-transactions-concurrence' },
  { src: 'cours/05-optimisation-indexation.md',      out: '05-optimisation-indexation' },
  { src: 'cours/06-securite-roles-sauvegarde.md',    out: '06-securite-roles-sauvegarde' },
  { src: 'cours/07-structures-architectures.md',     out: '07-structures-architectures' },
  { src: 'cours/08-ethique-donnees.md',              out: '08-ethique-donnees' },
]

// Copy shared images once to dist root
cpSync(resolve(root, 'cours/public/images'), resolve(root, 'dist/images'), { recursive: true })

for (const { src, out } of decks) {
  console.log(`\n📦 Building ${src} → dist/${out}`)
  execSync(
    `node ${resolve(root, 'node_modules/.bin/slidev')} build ${src} --base "/${out}/" --out ${resolve(root, 'dist', out)}`,
    { stdio: 'inherit', cwd: root }
  )
  // Replace duplicated images with symlink to shared dir
  const deckImages = resolve(root, 'dist', out, 'images')
  if (existsSync(deckImages)) {
    rmSync(deckImages, { recursive: true })
    symlinkSync('../images', deckImages)
  }
}

// Copy index page to dist root
cpSync(resolve(root, 'public/index.html'), resolve(root, 'dist/index.html'))

console.log('\n✅ All decks built successfully!')
