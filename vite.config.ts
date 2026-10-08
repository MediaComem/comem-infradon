import { defineConfig } from 'vite'
import { resolve } from 'path'

// Slidev 52.x — static src="/..." in Vue templates is compiled as an ES import,
// which the slide-import-guard rejects for absolute paths.
// Fix: use :src="'/images/...'" (dynamic binding) in slides — Vite won't
// transform dynamic bindings into static imports, so they're served at runtime
// from cours/public/ as plain URLs.
//
// server.fs.allow kept broad so any project-local assets are accessible.
export default defineConfig({
  server: {
    fs: {
      allow: [resolve(__dirname)],
    },
  },
})
