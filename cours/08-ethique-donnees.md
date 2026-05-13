---
theme: default
download: true
title: "08 - Éthique des données"
drawings:
    persist: false
transition: slide-left
mdc: true
fonts:
  sans: Roboto
  serif: Roboto Slab
  mono: Roboto Mono
layout: none
---

<div class="cover-custom">
  <img src="/images/logo.png" class="cover-logo" />
  <div class="cover-content">
    <h1 class="cover-title">08 - Éthique des données</h1>
    <p class="cover-subtitle">Infrastructure de données</p>
    <div style="display: flex; align-items: center; gap: 0.75rem; margin-top: 0.5rem;">
      <a href="https://github.com/MediaComem/comem-infradon" class="cover-email" style="display: flex; align-items: center; gap: 0.25rem;"><carbon-logo-github /> GitHub</a>
      <a href="https://creativecommons.org/licenses/by/4.0/"><img src="https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg" style="height: 12px; opacity: 0.6;" /></a>
    </div>
    <div class="cover-meta">
      <span class="cover-author">Noemi Romano</span>
      <a href="mailto:noemi.romano@heig-vd.ch" class="cover-email">noemi.romano@heig-vd.ch</a>
      <span class="cover-date">{{ new Date().toLocaleDateString('fr-CH') }}</span>
    </div>
  </div>
</div>

---
layout: section
---

# L'infrastructure des données comme industrie extractive

<p class="section-subtitle">Les coûts cachés du numérique</p>

---
layout: default
---

# Ce que coûte une infrastructure de données

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

L'infrastructure de données repose sur des **ressources physiques** :

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.6rem; margin-top: 0.8rem;">
<div class="box" style="text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-chip /></div><div style="font-weight: 600; font-size: 0.76rem;">Serveurs</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Électricité 24h/24</div></div>
<div class="box" style="text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-temperature /></div><div style="font-weight: 600; font-size: 0.76rem;">Eau</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Refroidissement</div></div>
<div class="box" style="text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-chemistry /></div><div style="font-weight: 600; font-size: 0.76rem;">Matériaux rares</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Lithium, cobalt</div></div>
<div class="box" style="text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-building /></div><div style="font-weight: 600; font-size: 0.76rem;">Bâtiments</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Hébergement</div></div>
<div class="box" style="text-align: center; grid-column: span 2;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-network-4 /></div><div style="font-weight: 600; font-size: 0.76rem;">Câbles sous-marins</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Connectivité mondiale</div></div>
</div>

</div>

<div style="display: flex; flex-direction: column; align-items: center; gap: 0.4rem;">
  <a href="https://whitmanwire.com/science-environment/2024/10/03/the-environmental-impact-of-data-centers-balancing-ai-growth-and-energy-infrastructure-in-eastern-washington/" target="_blank"><img src="/images/08-ethique/Aibadforenv_yee_es_3-edited-586x600.png" style="max-height: 340px; width: 100%; object-fit: contain; border-radius: 4px;" /></a>
  <div class="img-caption">Illustration · Emily Yee · <a href="https://whitmanwire.com/science-environment/2024/10/03/the-environmental-impact-of-data-centers-balancing-ai-growth-and-energy-infrastructure-in-eastern-washington/">Whitman Wire (2024)</a></div>
</div>

</div>

<div class="footer">Source · Crawford, <em>Atlas of AI</em> (2021) · <a href="https://www.iea.org/reports/electricity-2024">IEA · Electricity 2024</a></div>

---
layout: section
---

# Extraction minière et matériaux

<p class="section-subtitle">Lithium, cobalt et terres rares</p>

---
layout: default
---

# Lithium et cobalt

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Lithium : eau et communautés
- "Triangle du lithium" : Chili, Argentine, Bolivie
- Millions de litres/jour → pression sur les ressources locales
- Revenus captés par des multinationales, communautés indigènes affectées

### Cobalt : droits humains
- **+60%** de l'approvisionnement mondial vient de la RDC (République Démocratique du Congo)
- Mineurs artisanaux sans équipements, exposition à des substances toxiques
- Enfants parmi les travailleurs des mines

</div>

<div style="display: flex; flex-direction: column; gap: 0.5rem;">
  <div class="box">
    <div class="box-title">Où les trouve-t-on dans l'infrastructure ?</div>
    <ul>
      <li><strong>Batteries de secours (UPS)</strong> des datacenters → lithium</li>
      <li><strong>Puces, SSD, cartes réseau</strong> → cobalt dans les alliages</li>
      <li><strong>Smartphones et laptops</strong> des équipes → les deux</li>
      <li><strong>Câbles sous-marins</strong> → terres rares dans les amplificateurs</li>
    </ul>
  </div>
  <a href="https://reporterre.net/Guillaume-Pitron-Un-telephone-portable-ne-pese-pas-150-grammes-mais-150-kilos" target="_blank"><img src="/images/08-ethique/reporterre.webp" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
  <div class="img-caption">© Sanaga / <a href="https://reporterre.net/Guillaume-Pitron-Un-telephone-portable-ne-pese-pas-150-grammes-mais-150-kilos">Reporterre · G. Pitron : « Un téléphone ne pèse pas 150 g mais 150 kg »</a></div>
</div>

</div>

<div class="footer">Source · Crawford, <em>Atlas of AI</em>, Ch. 1 · Earth (2021) · <a href="https://reporterre.net/Guillaume-Pitron-Un-telephone-portable-ne-pese-pas-150-grammes-mais-150-kilos">Reporterre · Pitron</a> · <a href="https://www.klover.ai/why-ai-ethics-must-confront-environmental-and-labor-justice/">Klover.ai</a></div>

---
layout: section
---

# Énergie, eau et empreinte carbone

<p class="section-subtitle">Le cloud n'est pas dans les nuages</p>

---
layout: default
---

# Empreinte carbone du numérique

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

### Le numérique dans les émissions mondiales
- Numérique au global : **~4%** des émissions de CO₂ (IEA)
- Datacenters seuls : **~1%** (en forte croissance)
- Fabrication des équipements : souvent **> émissions d'exploitation**

### Ordres de grandeur
- Recherche Google : ~0.3 g CO₂
- Requête ChatGPT : ~0.15 g CO₂
- Email sans pièce jointe : ~4 g CO₂
- Email avec pièce jointe : ~50 g CO₂
- Fabrication d'un serveur : **plusieurs tonnes** CO₂

</div>

<div style="display: flex; flex-direction: column; gap: 0.4rem; align-items: center;">
  <a href="https://www.climatiq.io/blog/measure-greenhouse-gas-emissions-carbon-data-centres-cloud-computing" target="_blank"><img src="/images/08-ethique/cloud-emission.jpg" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
  <div class="img-caption"><a href="https://www.climatiq.io/blog/measure-greenhouse-gas-emissions-carbon-data-centres-cloud-computing">Climatiq · Measuring GHG emissions from cloud (2024)</a></div>
</div>

</div>

<div class="footer">Source · <a href="https://www.iea.org/reports/electricity-2024">IEA (2024)</a> · <a href="https://www.climatiq.io/blog/measure-greenhouse-gas-emissions-carbon-data-centres-cloud-computing">Climatiq (2024)</a> · <a href="https://news.mit.edu/2025/explained-generative-ai-environmental-impact-0117">MIT News (2025)</a></div>

---
layout: default
---

# Contexte suisse : datacenters

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Consommation électrique
- **6–8%** de l'électricité suisse (vs 3% mondiale)
- Projection : **10–15% d'ici 2030** (HSLU)
- **+4,6 TWh** supplémentaires nécessaires (ETH Zurich)

### Tensions et attentes
- Réseau haute tension zurichois déjà à la limite
- Migration vers Argovie et Schaffhouse
- **72%** des Suisses : énergie 100% renouvelable (AlgorithmWatch CH)
- **80%** : plus de transparence sur la consommation

</div>

<div style="display: flex; flex-direction: column; gap: 0.4rem;">

### Densité et croissance
- ~120 datacenters : parmi les plus fortes densités mondiales
- Canton de Zurich : 114 000 m² (≈ 16 terrains de football)
- 10+ nouveaux sites en construction

<a href="https://www.datacentermap.com/switzerland/" target="_blank"><img src="/images/08-ethique/data-centers-switzerland.png" style="width: 100%; object-fit: contain; border-radius: 4px; height: 200px" /></a>
<div class="img-caption"><a href="https://www.datacentermap.com/switzerland/">datacentermap.com · Suisse</a></div>
</div>

</div>

<div class="footer">Source · <a href="https://www.swissinfo.ch/eng/swiss-ai/can-switzerlands-power-grid-keep-up-with-its-data-centres/90710181">swissinfo.ch (2026)</a> · ETH Zurich · AlgorithmWatch CH · OFEN (2021)</div>

---
layout: default
---

# Crainte écologique ou opportunité économique ?

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Opportunité
- Emplois qualifiés et attractivité tech
- Revenus fiscaux pour les cantons
- Exportation de services numériques

### Crainte
- Pression sur le réseau électrique suisse
- Consommation d'eau (refroidissement)
- Conflits avec les objectifs climatiques
- Opacité des opérateurs sur la consommation réelle

</div>

<div style="display: flex; flex-direction: column; gap: 0.4rem;">
  <a href="https://www.rts.ch/info/economie/2026/article/entre-crainte-ecologique-et-opportunite-economique-l-expansion-des-datacenters-en-suisse-interroge-29235422.html" target="_blank"><img src="/images/08-ethique/crainte-ecologique-opportunite-econonique-rts.png" style="width: 100%; height: 120px; object-fit: cover; border-radius: 4px;" /></a>
  <iframe src="https://www.rts.ch/play/embed?urn=urn:rts:video:9c5086b3-8691-3d48-a06f-81ec2b9bb2b1&subdivisions=false" style="width: 100%; height: 210px; border: none; border-radius: 4px; display: block;" allowfullscreen allow="geolocation *; autoplay; encrypted-media"></iframe>
  <div class="img-caption"><a href="https://www.rts.ch/info/economie/2026/article/entre-crainte-ecologique-et-opportunite-economique-l-expansion-des-datacenters-en-suisse-interroge-29235422.html">RTS Forum · L'expansion des datacenters en Suisse interroge (2026)</a></div>
</div>

</div>

<div class="footer">Source · <a href="https://www.rts.ch/info/economie/2026/article/entre-crainte-ecologique-et-opportunite-economique-l-expansion-des-datacenters-en-suisse-interroge-29235422.html">RTS (2026)</a></div>

---
layout: none
---

<div style="position: absolute; inset: 0; overflow: hidden; background: #000; display: grid; grid-template-columns: 1fr 1fr 2fr; grid-template-rows: 1fr 1fr; gap: 2px;">
  <figure style="grid-column: 1; grid-row: 1 / span 2; margin: 0; position: relative; overflow: hidden;"><a href="https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace" target="_blank"><img src="/images/08-ethique/Data%20centers%20-C-Lignon-Julien%20Heil.jpg" style="width: 100%; height: 100%; object-fit: cover; display: block;" /></a><figcaption style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.7), transparent); color: #fff; font-size: 0.55rem; padding: 0.8rem 0.5rem 0.3rem; font-family: 'Roboto Mono', monospace;">Equinix GV2, Vernier (GE), 2009</figcaption></figure>
  <figure style="grid-column: 2; grid-row: 1 / span 2; margin: 0; position: relative; overflow: hidden;"><a href="https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace" target="_blank"><img src="/images/08-ethique/Data%20centers-E-Vermont-Julien%20Heil.jpg" style="width: 100%; height: 100%; object-fit: cover; display: block;" /></a><figcaption style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.7), transparent); color: #fff; font-size: 0.55rem; padding: 0.8rem 0.5rem 0.3rem; font-family: 'Roboto Mono', monospace;">Swisscom Geneva-Montbrillant, 1983</figcaption></figure>
  <figure style="grid-column: 3; grid-row: 1; margin: 0; position: relative; overflow: hidden;"><a href="https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace" target="_blank"><img src="/images/08-ethique/Data%20centers-B-Montbenon-2-Julien%20Heil.jpg" style="width: 100%; height: 100%; object-fit: cover; display: block;" /></a><figcaption style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.7), transparent); color: #fff; font-size: 0.55rem; padding: 0.8rem 0.5rem 0.3rem; font-family: 'Roboto Mono', monospace;">Swisscom Lausanne-Montbenon, 2014</figcaption></figure>
  <figure style="grid-column: 3; grid-row: 2; margin: 0; position: relative; overflow: hidden;"><a href="https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace" target="_blank"><img src="/images/08-ethique/Data%20centers-F-Gland-3-Julien%20Heil.jpg" style="width: 100%; height: 100%; object-fit: cover; display: block;" /></a><figcaption style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.7), transparent); color: #fff; font-size: 0.55rem; padding: 0.8rem 0.5rem 0.3rem; font-family: 'Roboto Mono', monospace;">Stack GEN02, Gland (VD), 2017</figcaption></figure>
  <div style="position: absolute; top: 0; left: 0; right: 0; background: linear-gradient(to bottom, rgba(0,0,0,0.7), transparent); padding: 1.2rem 1.5rem 2rem; pointer-events: none;">
    <h1 style="color: #fff; font-size: 1.5rem; font-weight: 700; margin: 0; letter-spacing: -0.02em;">Invisibles ? Les data centers dans l'espace</h1>
    <p style="color: rgba(255,255,255,0.6); font-size: 0.65rem; margin: 0.3rem 0 0 0; font-family: 'Roboto Mono', monospace;">Photographies · Julien Heil · <a href="https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace" style="color: rgba(255,255,255,0.6); pointer-events: all;">espazium.ch (2026)</a></p>
  </div>
</div>

---
layout: default
---

# Infomaniak

<div class="grid grid-cols-4 gap-3 mt-4">

<div class="box-sm">
  <div class="box-title">Énergie 100% verte</div>
  <ul>
    <li>60% hydro + 40% solaire</li>
    <li>Panneaux Meyer Burger (EU)</li>
    <li>Objectif 100% RE atteint</li>
  </ul>
</div>

<div class="box-sm">
  <div class="box-title">Compensation 200% CO₂</div>
  <ul>
    <li>Double des émissions compensées</li>
    <li>Couvre : fabrication, électricité, transport, vols</li>
  </ul>
</div>

<div class="box-sm">
  <div class="box-title">Récupération de chaleur</div>
  <ul>
    <li>D4 : <strong>100%</strong> de la chaleur fatale récupérée</li>
    <li>Injectée dans le chauffage à distance</li>
  </ul>
</div>

<div class="box-sm">
  <div class="box-title">Durée de vie étendue</div>
  <ul>
    <li>Serveurs : 7–10 ans → <strong>15 ans</strong></li>
    <li>ISO 14001, ISO 50001 (depuis 2015)</li>
  </ul>
</div>

</div>

<div style="margin-top: 0.5rem; height: 45vh; display: flex; flex-direction: column; align-items: center; gap: 0.3rem;">
  <a href="https://www.infomaniak.com/fr/ecologie" target="_blank" style="flex: 1; min-height: 0; display: block;"><img src="/images/08-ethique/infomaniak-nous-polluons.png" style="width: 100%; height: 100%; object-fit: contain; border-radius: 4px;" /></a>
  <div class="img-caption"><a href="https://www.infomaniak.com/fr/ecologie">infomaniak.com/fr/ecologie</a></div>
</div>

<div class="footer">Source · <a href="https://www.infomaniak.com/fr/ecologie">infomaniak.com/fr/ecologie</a></div>

---
layout: section
---

# Biais

<p class="section-subtitle">Quand les machines reproduisent nos préjugés</p>

---
layout: default
---

# Sources et conséquences des biais

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Sources de biais
- **Données d'entraînement** : historique discriminatoire utilisé comme vérité
- **Objectifs d'optimisation** : maximiser l'engagement favorise le contenu extrême
- **Boucles de rétroaction** : les prédictions influencent la réalité qu'elles mesurent
- **Choix de design** : quelles variables inclure, lesquelles ignorer ?

### Conséquences
- Discrimination systématique à grande échelle
- Opacité : décisions automatisées sans explication
- Difficulté à contester (boîte noire)

</div>

<div style="display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 0.5rem;">
  <img src="/images/08-ethique/megaphone.jpg" style="width: 100%; max-height: 260px; object-fit: contain; border-radius: 4px;" />
</div>

</div>

<div class="footer">Source · <a href="https://nyupress.org/9781479837243/algorithms-of-oppression/">Noble, <em>Algorithms of Oppression</em> (2018)</a></div>

---
layout: default
---

# Le cas COMPAS

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Qu'est-ce que COMPAS ?
- Utilisé par les tribunaux américains
- Prédit le risque de récidive (score de 1 à 10)
- Influence les décisions de libération conditionnelle

### ProPublica (2016) : enquête sur 7 000 détenu·e·s
- Taux de faux positifs **2× plus élevé** pour les personnes racisées
- Taux de faux négatifs **2× plus élevé** pour les personnes non racisées
- Le score intégrait des variables corrélées au phénotype

</div>

<div style="display: flex; flex-direction: column; gap: 0.5rem;">
  <div>
    <a href="https://medium.com/@danaytaman/algorithmic-bias-in-data-and-machine-learning-models-cc3ac681b440" target="_blank"><img src="/images/08-ethique/compas.webp" style="width: 100%; height: 190px; object-fit: contain; border-radius: 4px; display: block;" /></a>
    <div class="img-caption"><a href="https://medium.com/@danaytaman/algorithmic-bias-in-data-and-machine-learning-models-cc3ac681b440">Dayana Taman · Medium</a></div>
  </div>
  <div>
    <a href="https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing" target="_blank"><img src="/images/08-ethique/Risk3.png" style="width: 100%; height: 160px; object-fit: contain; border-radius: 4px; display: block;" /></a>
    <div class="img-caption"><a href="https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing">ProPublica · Machine Bias (2016)</a></div>
  </div>
</div>

</div>

<div class="footer">Source · <a href="https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing">ProPublica · Machine Bias (2016)</a></div>

---
layout: default
---

# Les données ne sont pas neutres

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

Chaque pipeline, chaque modèle repose sur des **choix humains** :

### Questions à se poser
- Qui décide **quoi collecter** ?
- Qui est **représenté** dans les données ?
- Qui **bénéficie** de l'analyse ?
- Qui **supporte** le coût de l'infrastructure ?
- Qui est **exclu** ou rendu invisible ?

</div>

<div class="flex items-center justify-center h-full">
  <a href="https://data-feminism.mitpress.mit.edu/" target="_blank" style="display: inline-block;">
    <img src="/images/01-introduction/Data_Feminism.jpg" style="height: 260px; width: auto; display: block; border-radius: 2px 6px 6px 2px; transform: perspective(600px) rotateY(-8deg); box-shadow: -6px 0 10px rgba(0,0,0,0.25), 6px 6px 30px rgba(0,0,0,0.4), inset -4px 0 8px rgba(0,0,0,0.15);" />
  </a>
</div>

</div>

<div class="box mt-4" style="background: #fef2f2; border-color: var(--heig-red);">
  <div class="box-title"><carbon-information /> À retenir</div>
  <div style="font-size: 0.65rem; color: #555; line-height: 1.5;">L'infrastructure de données n'est pas un outil neutre. Elle encode des priorités, des valeurs et des rapports de pouvoir.</div>
</div>

<div class="footer">Source · D'Ignazio & Klein, <em>Data Feminism</em> (2020) · Crawford, <em>Atlas of AI</em> (2021)</div>

---
layout: section
---

# Fin de vie et e-déchets

<p class="section-subtitle">L'autre face du numérique</p>

---
layout: default
---

# Fin de vie : l'e-waste invisible

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

### Cycle de renouvellement
- Hardware obsolète tous les 3–5 ans dans les datacenters
- La demande IA accélère encore ce rythme (Schneider Electric)
- Serveurs, cartes réseau, baies de stockage → tout finit remplacé

### Impacts sanitaires et environnementaux
- Plomb, mercure, cadmium dans les décharges
- **80%** des e-déchets mondiaux vers des pays à bas revenus
- Recycleurs exposés sans protection (ETH Zurich CSS, 2023)

</div>

<div style="display: flex; flex-direction: column; gap: 0.5rem;">
  <div class="box">
    <div class="box-title">Recommandations</div>
    <ul>
      <li>Concevoir pour la <strong>longévité</strong> → pas l'obsolescence programmée</li>
      <li>Transparence sur la fin de vie des équipements</li>
      <li>Infomaniak : durée de vie étendue à <strong>15 ans</strong></li>
    </ul>
  </div>
  <div>
    <a href="https://datacentremagazine.com/articles/schneider-electric-races-to-meet-ai-data-centre-demands" target="_blank"><img src="https://assets.bizclikmedia.net/900/e62dc1ec1aa0ca90dd81380d2859d86a:f95a70970d3645231fd3a0ccd2951ffe/gettyimages-1007702270-2048x2048.webp" style="width: 100%; height: 140px; object-fit: cover; border-radius: 4px; display: block;" /></a>
    <div class="img-caption"><a href="https://datacentremagazine.com/articles/schneider-electric-races-to-meet-ai-data-centre-demands">Data Centre Magazine · Schneider Electric & AI demand (2024)</a></div>
  </div>
  <div>
    <a href="https://ethz.ch/content/dam/ethz/special-interest/gess/cis/center-for-securities-studies/pdfs/PP11-3_2023-EN.pdf" target="_blank"><img src="https://css.ethz.ch/en/center/CSS-news/2023/08/mind-the-e-waste-a-case-for-switzerland/_jcr_content/par/lead/imagePanorama.imageformat.carousel.1496881384.jpg" style="width: 100%; height: 140px; object-fit: cover; border-radius: 4px; display: block;" /></a>
    <div class="img-caption"><a href="https://ethz.ch/content/dam/ethz/special-interest/gess/cis/center-for-securities-studies/pdfs/PP11-3_2023-EN.pdf">ETH Zurich CSS · Mind the E-Waste: A Case for Switzerland (2023)</a></div>
  </div>
</div>

</div>

<div class="footer">Source · Crawford, <em>Atlas of AI</em> (2021) · <a href="https://datacentremagazine.com/articles/schneider-electric-races-to-meet-ai-data-centre-demands">Data Centre Magazine</a> · <a href="https://ethz.ch/content/dam/ethz/special-interest/gess/cis/center-for-securities-studies/pdfs/PP11-3_2023-EN.pdf">ETH Zurich CSS (2023)</a></div>

---
layout: section
---

# Souveraineté numérique

<p class="section-subtitle">Qui contrôle vos données ?</p>

---
layout: default
---

# Souveraineté numérique : qu'est-ce que c'est ?

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

**Souveraineté numérique** : contrôler ses propres données et infrastructures **sans dépendre de tiers étrangers**

### Trois dimensions
- **Données** : où stockées ? quelle juridiction ?
- **Infrastructure** : qui possède et opère les serveurs ?
- **Logiciels** : open source ou plateformes propriétaires étrangères ?

### Pourquoi c'est un enjeu ?
- Données hébergées à l'étranger → soumises aux lois locales
- **Cloud Act (2018)** : accès aux données de sociétés US, partout dans le monde

</div>

<div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
  <a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/" target="_blank"><img src="/images/08-ethique/news-infomaniak.png" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
  <div class="img-caption"><a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/">Infomaniak · Souveraineté numérique de la Suisse (2021)</a></div>
  <a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html" target="_blank"><img src="/images/08-ethique/contrats-suisse-cloud.png" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
  <div class="img-caption"><a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html">RTS · Contrats cloud de la Confédération (oct. 2022)</a></div>
</div>

</div>

<div class="footer">Source · <a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/">Infomaniak · Souveraineté numérique (2021)</a> · <a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html">RTS (2022)</a></div>

---
layout: default
---

# Cloud externe : pour et contre

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Pour : efficacité et scalabilité
- PUE ~1.2 (hyperscalers) vs ~2.0 en infrastructure interne
- Économies d'échelle : infrastructure mutualisée
- Engagements renouvelables (Google, Microsoft : objectifs 100% RE)
- Redondance et résilience mondiale
- Pas de gestion de fin de vie matériel en interne

</div>

<div>

### Contre : dépendance et opacité
- **Cloud Act (2018)** : données accessibles par les autorités US
- Lock-in technologique et fournisseur
- Émissions de fabrication et fin de vie sous-estimées (rarement divulguées)
- Consommation réelle non divulguée par les opérateurs
- 3 acteurs contrôlent ~65% du marché mondial du cloud

</div>

</div>

<div class="box mt-3" style="background: #f0f6ff; border-color: #90b4d8;">
  <div class="box-title" style="color: #4a7fb5;"><carbon-book /> Définitions</div>
  <ul>
    <li><strong>PUE</strong> (Power Usage Effectiveness) : ratio énergie totale datacenter / énergie serveurs seuls — idéal = 1.0</li>
    <li><strong>Hyperscalers</strong> : grands opérateurs cloud mondiaux (AWS, Google Cloud, Azure)</li>
  </ul>
</div>

<div class="footer">Source · <a href="https://www.rts.ch/info/economie/2026/article/entre-crainte-ecologique-et-opportunite-economique-l-expansion-des-datacenters-en-suisse-interroge-29235422.html">RTS (2026)</a> · <a href="https://www.climatiq.io/blog/measure-greenhouse-gas-emissions-carbon-data-centres-cloud-computing">Climatiq</a> · <a href="https://www.sciencedirect.com/science/article/pii/S2666389925002788">ScienceDirect (2025)</a> · <a href="https://www.theguardian.com/technology/2026/apr/24/officials-hugely-underestimated-impact-of-ai-datacentres-on-uk-carbon-emissions">The Guardian (2026)</a> · <a href="https://www.seedling.earth/post/the-carbon-footprint-of-data-centres-our-guide">Seedling Earth</a></div>

---
layout: section
---

# RGPD et nLPD

<p class="section-subtitle">Cadre légal et responsabilités</p>

---
layout: default
---

# Le cadre légal

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### RGPD (UE) et nLPD (CH)

Deux réglementations qui encadrent le traitement des **données personnelles** :

- **RGPD** : Règlement Général sur la Protection des Données (EU, 2018)
- **nLPD** : nouvelle Loi sur la Protection des Données (Suisse, 2023)

S'appliquent dès qu'une **personne physique** est concernée : citoyen·ne·s, employé·e·s, technicien·ne·s.

</div>

<div>

<div class="box" style="margin-bottom: 0.8rem;">
  <div class="box-title">Droits des personnes concernées</div>
  <ul>
    <li>Accès à leurs données</li>
    <li>Rectification des erreurs</li>
    <li>Suppression ("droit à l'oubli")</li>
    <li>Portabilité (recevoir ses données dans un format standard)</li>
    <li>Opposition à certains traitements</li>
  </ul>
</div>

<div class="box" style="background: #fef2f2; border-color: var(--heig-red);">
  <div class="box-title"><carbon-information /> Dans votre projet</div>
  <div style="font-size: 0.65rem; color: #555; line-height: 1.5;">Les noms et contacts des technicien·ne·s sont des données personnelles. Leur traitement est encadré par la nLPD.</div>
</div>

</div>

</div>

<div class="footer">Source · <a href="https://www.fedlex.admin.ch/eli/cc/2022/491/fr">nLPD · fedlex.admin.ch</a> · <a href="https://eur-lex.europa.eu/legal-content/FR/TXT/?uri=CELEX:32016R0679">RGPD · eur-lex.europa.eu</a></div>

---
layout: default
---

# Données personnelles et données sensibles

<div class="grid grid-cols-2 gap-8 mt-4">

<div class="list-compact">

### Donnée personnelle
Toute information permettant d'identifier une **personne physique**
- Nom, prénom, adresse
- Email, numéro de téléphone
- Adresse IP, cookie
- Position GPS

### Donnée sensible
Sous-catégorie à **risque élevé de discrimination**
- Santé, handicap
- Origine raciale / ethnique
- Convictions religieuses / politiques
- Données biométriques / génétiques
- Vie et orientation sexuelle
- Casier judiciaire

</div>

<div style="display: flex; flex-direction: column; gap: 0.6rem;">

<div class="box">
  <div class="box-title">🇨🇭 nLPD · art. 5 let. c (2023)</div>
  <ul>
    <li>Santé, sphère intime</li>
    <li>Origine raciale</li>
    <li>Opinions religieuses, philosophiques, politiques, syndicales</li>
    <li>Poursuites pénales / administratives</li>
    <li>Mesures d'aide sociale</li>
    <li>Profil de personnalité</li>
  </ul>
</div>

<div class="box">
  <div class="box-title">🇪🇺 RGPD · art. 9 (2018)</div>
  <ul>
    <li>Origine raciale / ethnique</li>
    <li>Opinions politiques, convictions religieuses</li>
    <li>Données génétiques, biométriques</li>
    <li>Santé, orientation sexuelle</li>
    <li>Traitement <strong>interdit par défaut</strong></li>
  </ul>
</div>


</div>

</div>

<div class="footer">Source · <a href="https://www.fedlex.admin.ch/eli/cc/2022/491/fr">nLPD art. 5 · fedlex.admin.ch</a> · <a href="https://eur-lex.europa.eu/legal-content/FR/TXT/?uri=CELEX:32016R0679">RGPD art. 9 · eur-lex.europa.eu</a> · <a href="https://www.congress.gov/bill/115th-congress/senate-bill/2383">Cloud Act (2018)</a></div>

---
layout: default
---

# Privacy by design

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

**Privacy by design** : intégrer la protection des données **dès la conception**, pas en réaction à un incident.

### Principes
- Collecter **seulement ce qui est nécessaire** (minimisation des données)
- Définir une **durée de rétention** et supprimer après expiration
- **Chiffrer** les données sensibles au repos et en transit
- Limiter l'accès au **strict nécessaire** (principe du moindre privilège, <a href="https://comem-infradon.onrender.com/06-securite-roles-sauvegarde/" class="module-link">cours 06</a>)
- **Documenter** quelles données sont traitées, pour quoi et par qui

</div>

<div>

<div class="box" style="margin-bottom: 0.8rem;">
  <div class="box-title">Ce que ça implique pour l'infrastructure</div>
  <ul>
    <li>Logs d'audit (qui a accédé à quoi, quand)</li>
    <li>Politique de rétention automatisée (purge après N ans)</li>
    <li>Pseudonymisation ou anonymisation des données de test</li>
    <li>Localisation des données (pas transférer hors UE/CH sans cadre)</li>
  </ul>
</div>

<div class="box" style="background: #fffbe6; border-color: #f0d060;">
  <div class="box-title" style="color: #c8a000;"><carbon-warning-alt /> À noter</div>
  <div style="font-size: 0.65rem; color: #555; line-height: 1.5;">La conformité n'est pas une case à cocher. C'est un processus continu intégré dans l'architecture.</div>
</div>

</div>

</div>

<div class="footer">Source · <a href="https://www.edoeb.admin.ch/edoeb/fr/home/datenschutz/grundlagen/datenschutz-durch-technik.html">PFPDT · Privacy by Design</a></div>

---
layout: default
---

# Gouvernance des données

<div class="mt-2 list-compact">

### <a href="https://comem-infradon.onrender.com/07-structures-architectures/" class="module-link">Cours 07</a> : rappels
- **Catalogue de métadonnées** (Lakehouse) : schéma · propriétaire · lineage
- **Medallion** : Bronze → Silver → Gold → cycle de vie contrôlé
- **Gouvernance fédérée** (Data Mesh) : conformité RGPD / nLPD automatisée par la plateforme

</div>

<div class="mt-3 grid grid-cols-2 gap-3">

<div class="box">
  <div class="box-title"><carbon-catalog /> Catalogue de données</div>
  <ul>
    <li>Quelles données · où · qui est responsable · quelle qualité</li>
    <li>Schéma · propriétaire · lineage (Lakehouse)</li>
    <li>"Données comme produit" (Data Mesh)</li>
  </ul>
</div>

<div class="box">
  <div class="box-title"><carbon-task /> Registre des traitements</div>
  <ul>
    <li>Obligatoire nLPD pour traitements de données sensibles à grande échelle</li>
    <li>Chaque domaine responsable à la source (gouvernance fédérée)</li>
  </ul>
</div>

<div class="box">
  <div class="box-title"><carbon-user-access /> Contrôle d'accès granulaire</div>
  <ul>
    <li>GRANT/REVOKE · principe du moindre privilège (<a href="https://comem-infradon.onrender.com/06-securite-roles-sauvegarde/" class="module-link">cours 06</a>)</li>
    <li>Automatisé par la plateforme en Data Mesh (<a href="https://comem-infradon.onrender.com/07-structures-architectures/" class="module-link">cours 07</a>)</li>
  </ul>
</div>

<div class="box">
  <div class="box-title"><carbon-recycle /> Cycle de vie des données</div>
  <ul>
    <li>Medallion : Bronze → Silver → Gold → archivage</li>
    <li>Durées de rétention · anonymisation · suppression (nLPD)</li>
  </ul>
</div>

</div>

<div class="box mt-3" style="background: #fef2f2; border-color: var(--heig-red);">
  <div class="box-title"><carbon-information /> Dans votre projet</div>
  <div style="font-size: 0.65rem; color: #555; line-height: 1.5;">La gouvernance n'est pas réservée aux grandes entreprises. Même un projet de service communal traitant des noms et des positions GPS a des obligations.</div>
</div>

---
layout: section
---

# Questions ouvertes

<p class="section-subtitle">À traiter dans le poster de rendu</p>

---
layout: default
---

# Pour l'ingénieure et l'ingénieur de données

<div class="mt-4" style="font-size: 0.88rem;">

Ces questions n'ont pas de réponse unique. Choisissez-en **au moins une** à analyser dans votre poster de rendu.

</div>

<div class="mt-4 grid grid-cols-2 gap-4" style="font-size: 0.85rem;">

<div class="question-box">
  À qui appartiennent les données du mobilier urbain d'Yverdon ? À la commune, aux habitant·e·s, au prestataire qui a développé le système ?
</div>

<div class="question-box">
  Si un algorithme prédit qu'un banc est "prioritaire" pour une rénovation, et que ce banc est dans un quartier défavorisé : est-ce un résultat équitable ou le signe d'un biais dans les données de signalement ?
</div>

<div class="question-box">
  Votre base de données contient des noms de technicien·ne·s. Pendant combien d'années faut-il conserver cet historique ? Qui décide ?
</div>

<div class="question-box">
  Si le Service technique décide d'analyser les déplacements des technicien·ne·s via GPS pour optimiser les tournées : quelles questions éthiques cela soulève-t-il ?
</div>

</div>

---
layout: default
---

# Poster A3 : consignes de rendu

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

### Structure (A3 portrait)

<div style="border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem; display: grid; grid-template-columns: 1fr; grid-template-rows: auto auto auto auto; gap: 3px; background: #f9f9f9; font-family: 'Roboto Mono', monospace; font-size: 0.58rem; margin-top: 0.5rem;">
  <div style="background: #fff; border: 1px solid #ddd; border-radius: 2px; padding: 0.4rem; color: #555; line-height: 1.4;">Contexte & périmètre</div>
  <div style="background: #fff; border: 2px solid var(--heig-red); border-radius: 2px; padding: 0.8rem 0.4rem; color: #333; line-height: 1.4; font-weight: 600; text-align: center;">Modèle logique<br/>(E/R · tables · relations)</div>
  <div style="background: #fff; border: 1px solid #ddd; border-radius: 2px; padding: 0.4rem; color: #555; line-height: 1.4;">Workflow de pensée</div>
  <div style="background: #fef2f2; border: 1px solid var(--heig-red); border-radius: 2px; padding: 0.4rem; color: #555; line-height: 1.4;">Réflexion éthique · nLPD · questions ouvertes</div>
</div>

<div class="box mt-3" style="background: #fef2f2; border-color: var(--heig-red);">
  <div class="box-title"><carbon-calendar /> Présentation · 20 mai &nbsp;|&nbsp; Rendu final · 31 mai</div>
  <div style="font-size: 0.65rem; color: #555; line-height: 1.6;">
    <strong>20 mai</strong> : poster A3 imprimé · affiché en classe · présentation et discussion<br/>
    <strong>31 mai</strong> : scripts SQL · jalons · adaptations selon retour des présentations · lien GitHub<br/>
    <strong>GitHub</strong> : <code>git clone</code> + <code>docker compose up -d</code> → base de données opérationnelle
  </div>
</div>
</div>

<div style="display: flex; flex-direction: column; gap: 0.4rem;">

<div class="box-sm">
  <div class="box-title">Contexte & périmètre</div>
  <ul>
    <li>Projet · données sources · périmètre</li>
    <li>Contraintes identifiées</li>
  </ul>
</div>

<div class="box-sm">
  <div class="box-title">Modèle logique <em>(zone centrale)</em></div>
  <ul>
    <li>Schéma UML · tables · relations · cardinalités</li>
    <li>Contraintes · index clés · types</li>
  </ul>
</div>

<div class="box-sm">
  <div class="box-title">Workflow de pensée</div>
  <ul>
    <li>Décisions de modélisation et pourquoi</li>
    <li>Alternatives rejetées · compromis</li>
    <li>Difficultés rencontrées</li>
  </ul>
</div>

<div class="box-sm">
  <div class="box-title">Réflexion éthique <em>(bandeau bas)</em></div>
  <ul>
    <li>Au moins une question de ce cours</li>
    <li>Gouvernance · nLPD · accès · cycle de vie</li>
  </ul>
</div>

</div>

</div>



---
layout: default
---

# Récapitulatif du semestre

<div class="mt-4" style="font-size: 0.85rem;">

1. **Introduction et fondamentaux** : CRUD, ACID, modélisation relationnelle, OLTP vs OLAP
2. **Import et nettoyage** : staging, TRIM, COALESCE, regexp_replace, dédoublonnage
3. **Transactions et concurrence** : niveaux d'isolation, verrous, deadlocks
4. **Optimisation et indexation** : EXPLAIN ANALYZE, B-tree, GIN, GiST
5. **Sécurité, rôles et sauvegarde** : GRANT/REVOKE, principe du moindre privilège, pg_dump
6. **Structures et flux de données** : NoSQL, JSONB, ETL/ELT, triggers, CDC, dbt
7. **Architectures modernes** : Data mesh, Medallion, Lakehouse, RAG
8. **Éthique et durabilité** : impact environnemental, biais algorithmiques, Data Feminism, RGPD/nLPD

</div>

<div class="box mt-4" style="background: #fef2f2; border-color: var(--heig-red);">
  <div class="box-title"><carbon-information /> À retenir</div>
  <div style="font-size: 0.65rem; color: #555; line-height: 1.5;">Une infrastructure de données n'est pas qu'un problème technique. C'est un système sociotechnique avec des conséquences réelles sur des personnes réelles.</div>
</div>

---
layout: default
---

# Ressources

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

### Livres

- **Data Feminism** · D'Ignazio & Klein (2020)
  <br><small>MIT Press · <a href="https://data-feminism.mitpress.mit.edu/">accès libre en ligne</a></small>

- **Atlas of AI** · Crawford (2021)
  <br><small>Yale University Press</small>

- **Data Mesh** · Dehghani (2022)
  <br><small>O'Reilly Media</small>

- **Designing Data-Intensive Applications** · Kleppmann (2017)
  <br><small>O'Reilly Media</small>

</div>

<div>

### En ligne

- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html) · martinfowler.com
- [Medallion Architecture](https://www.databricks.com/glossary/medallion-architecture) · Databricks
- [Gender Shades](http://gendershades.org/) · Buolamwini & Gebru
- [Machine Bias](https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing) · ProPublica
- [Enjeux et perspectives pour une IA éthique et durable](https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr) · Annales des Mines n°29 (2025)
- [Explained: Generative AI's environmental impact](https://news.mit.edu/2025/explained-generative-ai-environmental-impact-0117) · MIT News (2025)
- [MIT GenAI Impact Paper](https://mit-genai.pubpub.org/pub/8ulgrckc/release/2) · MIT (2025)
- [PFPDT · Protection des données](https://www.edoeb.admin.ch/) · edoeb.admin.ch

</div>

</div>

---
layout: end
---

# Questions ?
