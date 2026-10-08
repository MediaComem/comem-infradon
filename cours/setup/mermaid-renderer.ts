import { defineMermaidRendererSetup } from '@slidev/types'
import mermaid from 'mermaid/dist/mermaid.esm.mjs'
import mermaidSetup from './mermaid'

// `Mermaid.vue` injecte `theme: 'dark'` en mode sombre, apres le setup :
// la palette de `mermaid.ts` est alors ecrasee. Ce renderer ignore ce theme
// impose et rend la main au style defini dans `mermaid.ts`.
let counter = 0

export default defineMermaidRendererSetup(() => {
  return async (code, options = {}) => {
    const { theme: _ignored, ...rest } = options

    mermaid.initialize({
      startOnLoad: false,
      ...(await mermaidSetup()),
      ...rest,
    })

    const container = document.getElementById('mermaid-rendering-container') ?? undefined
    const { svg } = await mermaid.render(`mermaid-comem-${counter++}`, code, container)
    return svg
  }
})
