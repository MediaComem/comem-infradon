import { defineMermaidSetup } from '@slidev/types'

// Palette noir et gris, alignee sur les tokens du theme.
// Mermaid calcule des nuances derivees a partir de ces valeurs :
// leur passer des `var(--token)` casserait le rendu, d'ou les hexadecimaux.
export default defineMermaidSetup(() => ({
  theme: 'base',
  themeVariables: {
    fontFamily: "'Atkinson Hyperlegible Mono', monospace",
    fontSize: '13px',

    primaryColor: '#f5f5f5',
    primaryTextColor: '#111111',
    primaryBorderColor: '#111111',
    secondaryColor: '#ffffff',
    tertiaryColor: '#fafafa',
    lineColor: '#666666',
    textColor: '#111111',

    // Diagrammes entite-association
    attributeBackgroundColorOdd: '#ffffff',
    attributeBackgroundColorEven: '#f5f5f5',
  },
}))
