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

# Impact environnemental

<p class="section-subtitle">Le cloud n'est pas dans les nuages</p>

---
layout: default
---

# Ce que coûte une infrastructure de données

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

L'infrastructure de données repose sur des **ressources physiques** :

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.6rem; font-size: 0.82rem; margin-top: 0.8rem;">
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem 0.7rem; text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-chip /></div><div style="font-weight: 600; font-size: 0.76rem;">Serveurs</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Électricité 24h/24</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem 0.7rem; text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-temperature /></div><div style="font-weight: 600; font-size: 0.76rem;">Eau</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Refroidissement</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem 0.7rem; text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-chemistry /></div><div style="font-weight: 600; font-size: 0.76rem;">Matériaux rares</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Lithium, cobalt</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem 0.7rem; text-align: center;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-building /></div><div style="font-weight: 600; font-size: 0.76rem;">Bâtiments</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Hébergement</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem 0.7rem; text-align: center; grid-column: span 2;"><div style="font-size: 1.2rem; margin-bottom: 0.2rem;"><carbon-network-4 /></div><div style="font-weight: 600; font-size: 0.76rem;">Câbles sous-marins</div><div style="font-size: 0.72rem; color: #555; margin-top: 0.15rem;">Connectivité mondiale</div></div>
</div>

</div>

<div style="display: flex; flex-direction: column; align-items: center; gap: 0.4rem;">
<a href="https://whitmanwire.com/science-environment/2024/10/03/the-environmental-impact-of-data-centers-balancing-ai-growth-and-energy-infrastructure-in-eastern-washington/" target="_blank"><img src="/images/08-ethique/Aibadforenv_yee_es_3-edited-586x600.png" style="max-height: 340px; width: 100%; object-fit: contain; border-radius: 4px;" /></a>
<div style="font-size: 0.68rem; color: #9e9e9e; text-align: center;">Illustration · Emily Yee · <a href="https://whitmanwire.com/science-environment/2024/10/03/the-environmental-impact-of-data-centers-balancing-ai-growth-and-energy-infrastructure-in-eastern-washington/" style="color: #9e9e9e;">Whitman Wire (2024)</a></div>
</div>

</div>

<div class="footer">Source · Crawford, <em>Atlas of AI</em> (2021) · <a href="https://www.iea.org/reports/electricity-2024">IEA — Electricity 2024</a></div>

---
layout: default
---

# La Suisse et ses datacenters

<div class="grid grid-cols-2 gap-8 mt-4">

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.7rem; font-size: 0.82rem; align-content: start;">

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-data-center style="color: #666;" /> ~120 datacenters</div>
  Parmi les plus fortes densités au monde. 10+ nouveaux sites en construction. Principaux acteurs : Google, Microsoft, AWS, Equinix, Green Datacenter.
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-lightning style="color: #666;" /> 6-8% de l'électricité suisse</div>
  Aujourd'hui, contre 3% en moyenne mondiale. Pourrait atteindre <strong>10-15% d'ici 2030</strong>, selon Adrian Altenburger (HSLU). Plus que toute la consommation du canton de Zurich en 2023.
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-warning-alt style="color: #C1002A;" /> Zurich : réseau saturé</div>
  Le réseau haute tension est déjà à la limite dans plusieurs zones. Certains opérateurs migrent vers Argovie et Schaffhouse. Irlande et Pays-Bas ont déjà gelé les nouvelles constructions.
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-user-multiple style="color: #666;" /> Opinion publique</div>
  <strong>72%</strong> des Suisses souhaitent que les nouveaux datacenters soient alimentés uniquement en énergie renouvelable. <strong>80%</strong> veulent plus de transparence sur la consommation. (AlgorithmWatch CH)
</div>

</div>

<div style="display: flex; flex-direction: column; gap: 0.5rem;">
  <div style="display: flex; gap: 0.5rem; align-items: flex-start;">
    <div style="flex: 1;">
      <iframe src="https://www.rts.ch/play/embed?urn=urn:rts:video:13475123" style="width: 100%; height: 200px; border: none; border-radius: 4px; display: block;" allowfullscreen></iframe>
      <div style="font-size: 0.65rem; color: #9e9e9e; margin-top: 0.25rem; text-align: center;"><a href="https://www.rts.ch/play/tv/-/video/-?urn=urn:rts:video:13475123" style="color: #9e9e9e;">RTS — Le diesel des datacenters (2022)</a></div>
    </div>
    <div style="flex: 1;">
      <a href="https://www.swissinfo.ch/eng/swiss-ai/can-switzerlands-power-grid-keep-up-with-its-data-centres/90710181" target="_blank"><img src="/images/08-ethique/swissinfo-data-centers.png" style="width: 100%; height: 200px; object-fit: cover; border-radius: 4px; display: block;" /></a>
      <div style="font-size: 0.65rem; color: #9e9e9e; margin-top: 0.25rem; text-align: center;"><a href="https://www.swissinfo.ch/eng/swiss-ai/can-switzerlands-power-grid-keep-up-with-its-data-centres/90710181" style="color: #9e9e9e;">swissinfo.ch (2026)</a></div>
    </div>
  </div>
  <div style="display: flex; flex-direction: column; align-items: center;">
    <a href="https://www.datacentermap.com/switzerland/" target="_blank"><img src="/images/08-ethique/data-centers-switzerland.png" style="max-height: 100px; object-fit: contain; border-radius: 4px;" /></a>
    <div style="font-size: 0.62rem; color: #9e9e9e; margin-top: 0.15rem;"><a href="https://www.datacentermap.com/switzerland/" style="color: #9e9e9e;">datacentermap.com — Suisse</a></div>
  </div>
</div>

</div>

<div class="footer">Source · <a href="https://www.swissinfo.ch/eng/swiss-ai/can-switzerlands-power-grid-keep-up-with-its-data-centres/90710181">swissinfo.ch (2026)</a> · <a href="https://www.rts.ch/play/tv/-/video/-?urn=urn:rts:video:13475123">RTS (2023)</a></div>

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

# Les chiffres concrets : Suisse

<div class="mt-4" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; font-size: 0.84rem;">

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-lightning style="color: #666;" /> Consommation électrique</div>
  Les datacenters représentent <strong>6-8% de l'électricité suisse</strong> aujourd'hui, contre 3% en moyenne mondiale. Projection : <strong>10-15% d'ici 2030</strong>, soit plus que toute la consommation du canton de Zurich en 2023.
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-data-center style="color: #666;" /> Densité record</div>
  ~<strong>120 datacenters</strong> en Suisse, parmi les plus fortes densités au monde par habitant. Le canton de Zurich abrite plus de <strong>114 000 m²</strong> de surface datacenter — l'équivalent de 16 terrains de football.
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-warning-alt style="color: #C1002A;" /> Réseau sous tension</div>
  L'ETH Zurich estime que la Suisse devra produire ou importer <strong>+4,6 TWh</strong> supplémentaires pour satisfaire la demande des datacenters. Le réseau haute tension zurichois est déjà <strong>à la limite</strong> dans plusieurs zones.
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-user-multiple style="color: #666;" /> Ce que veulent les Suisses</div>
  <strong>72%</strong> souhaitent que les nouveaux datacenters soient alimentés uniquement en énergie renouvelable. <strong>80%</strong> réclament plus de transparence sur leur consommation réelle. (AlgorithmWatch CH)
</div>

</div>

<div class="accent-box mt-4">

Plus de <strong>40%</strong> du potentiel d'efficacité énergétique des datacenters suisses reste inexploité — accessible via une meilleure gestion IT, selon l'Office fédéral de l'énergie (OFEN, 2021).

</div>

<div style="background: #fef2f2; border: 1px solid #C1002A; border-radius: 4px; padding: 0.55rem 0.85rem; margin-top: 0.6rem; font-size: 0.83rem;"><div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.2rem; color: #C1002A;"><carbon-warning-alt /> Impact de l'IA générative</div>L'IA amplifie ces chiffres : chaque requête ChatGPT consomme ~<strong>5x plus</strong> qu'une recherche Google. L'entraînement d'un LLM mobilise énergie, eau (refroidissement GPU) et matériaux rares à grande échelle. Source · <a href="https://news.mit.edu/2025/explained-generative-ai-environmental-impact-0117" style="color: #C1002A;">MIT News (2025)</a></div>

<div class="footer">Source · <a href="https://www.swissinfo.ch/eng/swiss-ai/can-switzerlands-power-grid-keep-up-with-its-data-centres/90710181">swissinfo.ch (2026)</a> · ETH Zurich · AlgorithmWatch CH · OFEN (2021)</div>

---
layout: default
---

# Infomaniak

<div class="grid grid-cols-2 gap-8 mt-4">

<div style="display: flex; flex-direction: column; gap: 0.65rem; font-size: 0.83rem;">
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;"><div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-lightning style="color: #666;" /> Énergie 100% verte</div>60% hydroélectricité + 40% solaire/petite hydro. Propres centrales solaires avec panneaux européens (Meyer Burger). Objectif 100% atteint.</div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;"><div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-recycle style="color: #666;" /> Compensation 200% CO2</div>Compense le double de ses émissions : fabrication des serveurs, électricité, transport des collaborateurs, vols d'affaires.</div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;"><div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-temperature style="color: #666;" /> Récupération de chaleur</div>Le datacenter D4 récupère <strong>100% de la chaleur fatale</strong> des serveurs et l'injecte dans le réseau de chauffage à distance pour des milliers de foyers.</div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;"><div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-time style="color: #666;" /> Durée de vie étendue</div>Durée de vie des serveurs étendue de 7-10 ans à <strong>15 ans</strong> pour réduire l'empreinte carbone de la fabrication. Certifications ISO 14001, ISO 50001 (depuis 2015).</div>
</div>

<div style="display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 0.4rem;">
<a href="https://www.infomaniak.com/fr/ecologie" target="_blank"><img src="/images/08-ethique/infomaniak-nous-polluons.png" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
<div style="font-size: 0.65rem; color: #9e9e9e; text-align: center;"><a href="https://www.infomaniak.com/fr/ecologie" style="color: #9e9e9e;">infomaniak.com/fr/ecologie</a></div>
</div>

</div>

<div class="accent-box mt-4">

Infomaniak est basé à Genève. Un exemple suisse de datacenter qui assume sa pollution et investit structurellement pour la réduire — plutôt que de la rendre invisible.

</div>

<div class="footer">Source · <a href="https://www.infomaniak.com/fr/ecologie">infomaniak.com/fr/ecologie</a></div>

---
layout: default
---

# Souveraineté numérique : qu'est-ce que c'est ?

<div class="grid grid-cols-2 gap-8 mt-4">

<div style="font-size: 0.85rem;">

La **souveraineté numérique** désigne la capacité d'un État, d'une entreprise ou d'un individu à **contrôler ses propres données, infrastructures et services numériques** sans dépendre de tiers étrangers.

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem; margin-top: 0.7rem;"><div style="font-weight: 600; margin-bottom: 0.2rem;">Trois dimensions</div><ul style="padding-left: 1rem; margin: 0.3rem 0 0 0;"><li><strong>Données</strong> : où sont-elles stockées ? Sous quelle juridiction ?</li><li><strong>Infrastructure</strong> : qui possède et opère les serveurs ?</li><li><strong>Logiciels</strong> : open source ou dépendance à des plateformes propriétaires étrangères ?</li></ul></div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem; margin-top: 0.6rem;"><div style="font-weight: 600; margin-bottom: 0.2rem;">Pourquoi c'est un enjeu ?</div>Les données hébergées à l'étranger sont soumises aux lois locales — dont le <strong>Cloud Act américain</strong> (2018), qui permet aux autorités US d'accéder aux données de sociétés américaines, où qu'elles soient stockées.</div>

</div>

<div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
<a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/" target="_blank"><img src="/images/08-ethique/news-infomaniak.png" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
<div style="font-size: 0.62rem; color: #9e9e9e; text-align: center;"><a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/" style="color: #9e9e9e;">Infomaniak — Souveraineté numérique de la Suisse (2021)</a></div>
<a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html" target="_blank"><img src="/images/08-ethique/contrats-suisse-cloud.png" style="width: 100%; object-fit: contain; border-radius: 4px;" /></a>
<div style="font-size: 0.62rem; color: #9e9e9e; text-align: center;"><a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html" style="color: #9e9e9e;">RTS — Contrats cloud de la Confédération (oct. 2022)</a></div>
</div>

</div>

<div class="footer">Source · <a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/">Infomaniak — Souveraineté numérique (2021)</a> · <a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html">RTS (2022)</a></div>

---
layout: default
---

# La Suisse et le cloud fédéral

<div class="grid grid-cols-2 gap-8 mt-4">

<div style="font-size: 0.85rem;">

En 2022, la Confédération suisse a signé des contrats cloud avec **5 géants du numérique** pour un montant de **CHF 110 millions** sur 5 ans.

<div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 0.5rem; margin-top: 0.7rem; font-size: 0.78rem; text-align: center;">
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.4rem;"><img src="https://cdn.simpleicons.org/amazonaws/FF9900" style="height: 20px; margin-bottom: 0.2rem;" /><div>Amazon AWS</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.4rem;"><img src="https://cdn.simpleicons.org/microsoftazure/0078D4" style="height: 20px; margin-bottom: 0.2rem;" /><div>Microsoft Azure</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.4rem;"><img src="https://cdn.simpleicons.org/oracle/F80000" style="height: 20px; margin-bottom: 0.2rem;" /><div>Oracle</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.4rem;"><img src="https://cdn.simpleicons.org/ibm/052FAD" style="height: 20px; margin-bottom: 0.2rem;" /><div>IBM</div></div>
<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.4rem;"><img src="https://cdn.simpleicons.org/alibabacloud/FF6A00" style="height: 20px; margin-bottom: 0.2rem;" /><div>Alibaba Cloud</div></div>
<div style="background: #fef2f2; border: 1px solid #C1002A; border-radius: 4px; padding: 0.4rem; color: #C1002A; font-weight: 600; display: flex; align-items: center; justify-content: center;">0 acteur suisse ou européen</div>
</div>

<div style="background: #fffbe6; border: 1px solid #f0d060; border-radius: 4px; padding: 0.55rem 0.85rem; margin-top: 0.7rem; font-size: 0.82rem;"><carbon-warning-alt style="color: #c8a000;" /> Les critères du appel d'offres (24+ services sur 32, présence sur 3 continents) excluaient structurellement les prestataires suisses et européens.</div>

</div>

<div style="font-size: 0.85rem;">

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.6rem 0.85rem; margin-bottom: 0.6rem;"><div style="font-weight: 600; margin-bottom: 0.2rem;">Ce que ça implique</div><ul style="padding-left: 1rem; margin: 0;"><li>Les données de la Confédération hébergées par des entreprises étrangères</li><li>Soumises potentiellement au <strong>Cloud Act</strong> américain</li><li>Dépendance technologique à long terme</li></ul></div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.6rem 0.85rem;"><div style="font-weight: 600; margin-bottom: 0.2rem;">La question posée</div>Un pays peut-il déléguer son infrastructure numérique à des acteurs étrangers <strong>sans perdre le contrôle</strong> de ses propres données publiques ?</div>

</div>

</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.5rem 0.7rem; margin-top: 0.6rem; font-size: 0.82rem; display: flex; align-items: center; gap: 0.7rem;"><a href="https://www.letemps.ch/cyber/souverainete-numerique/infomaniak-retire-son-recours-contre-la-prolongation-par-la-confederation-des-contrats-avec-les-geants-du-cloud" target="_blank"><img src="/images/08-ethique/le-temps-infomaniak.png" style="height: 60px; object-fit: contain; border-radius: 3px; flex-shrink: 0;" /></a><div>Infomaniak avait déposé un recours contre la prolongation des contrats — puis l'a retiré. <a href="https://www.letemps.ch/cyber/souverainete-numerique/infomaniak-retire-son-recours-contre-la-prolongation-par-la-confederation-des-contrats-avec-les-geants-du-cloud" style="color: #555; font-style: italic;">Le Temps</a></div></div>

<div class="footer">Source · <a href="https://news.infomaniak.com/souverainete-numerique-de-la-suisse/">Infomaniak (juil. 2021)</a> · <a href="https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html">RTS (oct. 2022)</a> · <a href="https://www.letemps.ch/cyber/souverainete-numerique/infomaniak-retire-son-recours-contre-la-prolongation-par-la-confederation-des-contrats-avec-les-geants-du-cloud">Le Temps</a></div>

---
layout: default
---

# La chaîne d'approvisionnement invisible

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

Derrière chaque requête SQL se cache une longue chaîne :


- **Extraction minière** : lithium, cobalt, terres rares pour les puces et batteries
- **Fabrication** : usines avec conditions de travail et bilan carbone importants
- **Transport** : acheminement global des composants
- **Exploitation** : technicien·ne·s qui maintiennent les serveurs 24h/24
- **Fin de vie** : déchets électroniques, souvent mal recyclés


</div>

<div class="flex items-center justify-center h-full">

<div style="height: 220px; background: #f5f5f5; border: 1px dashed #ccc; border-radius: 4px; display: flex; align-items: center; justify-content: center; color: #9e9e9e; font-family: 'Roboto Mono', monospace; font-size: 0.7rem; text-align: center; padding: 1rem; line-height: 1.5;">carte / schéma de la chaîne<br/>d'approvisionnement numérique</div>

</div>

</div>

<div class="footer">Source · Crawford, <em>Atlas of AI</em>, Ch. 1 — Earth (2021)</div>

---
layout: section
---

# Biais et représentation

<p class="section-subtitle">Ce que les données ne voient pas</p>

---
layout: default
---

# Garbage in, garbage out, amplifié par l'IA

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

Les algorithmes apprennent à partir de données historiques. Si ces données **reflètent des inégalités passées**, l'algorithme les reproduit et les amplifie.


- **COMPAS** (outil de prédiction de récidive, USA) : classait les personnes noires comme deux fois plus à risque que les personnes blanches pour des délits similaires
- **Amazon Recruitment Tool** : outil d'évaluation de CV pénalisait automatiquement les candidatures avec le mot "femmes"
- **Reconnaissance faciale** : taux d'erreur jusqu'à **35%** sur les visages de femmes à peau foncée vs **1%** sur les hommes à peau claire


</div>

<div class="flex items-center justify-center h-full">

<div style="height: 220px; background: #f5f5f5; border: 1px dashed #ccc; border-radius: 4px; display: flex; align-items: center; justify-content: center; color: #9e9e9e; font-family: 'Roboto Mono', monospace; font-size: 0.7rem; text-align: center; padding: 1rem; line-height: 1.5;">illustration / BD<br/>sur les biais algorithmiques</div>

</div>

</div>

<div class="footer">Source · <a href="https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing">ProPublica — Machine Bias</a> · Buolamwini & Gebru, <em>Gender Shades</em> (2018)</div>

---
layout: default
---

# Les données ne sont pas neutres

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

Chaque base de données, chaque pipeline, chaque modèle d'IA repose sur des **choix humains** :


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

<div class="accent-box mt-4">

L'infrastructure de données n'est pas un outil neutre. Elle encode des priorités, des valeurs et des rapports de pouvoir.

</div>

<div class="footer">Source · D'Ignazio & Klein, <em>Data Feminism</em> (2020) · Crawford, <em>Atlas of AI</em> (2021)</div>

---
layout: default
---

# Madagascar, terrain d'entraînement de l'IA

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<a href="https://pulitzercenter.org/fr/stories/madagascar-terrain-dentrainement-de-lia" target="_blank" style="display: block; position: relative; border-radius: 4px; overflow: hidden;"><img src="/images/08-ethique/madagascar%201.jpg.webp" style="width: 100%; height: 280px; object-fit: cover; display: block; border-radius: 4px;" /></a>
<div style="font-size: 0.62rem; color: #9e9e9e; margin-top: 0.3rem; line-height: 1.4;">Fondée en 2015, TelesourcIA est une des plus anciennes entreprises d'annotation d'Antananarivo. La compagnie peut employer jusqu'à 300 personnes.<br/><span style="font-style: italic;">Image · Eugénie Baccot / Le Temps</span></div>

</div>

<div style="font-size: 0.85rem;">

Derrière chaque modèle d'IA, des milliers d'humains **annotent les données** — souvent invisibles, souvent précaires.

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem; margin-top: 0.7rem;"><div style="font-weight: 600; margin-bottom: 0.2rem;">Ce qu'ils font</div>Classer des images, transcrire de l'audio, modérer des contenus violents, corriger des réponses de chatbots. Un travail répétitif, invisible, mal rémunéré — qui rend l'IA "intelligente".</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem; margin-top: 0.6rem;"><div style="font-weight: 600; margin-bottom: 0.2rem;">Pourquoi Madagascar ?</div>Faibles salaires, francophonie, jeune population instruite. Des entreprises comme TelesourcIA (fondée en 2015, jusqu'à 300 employés) répondent à la demande mondiale en annotation de données.</div>

</div>

</div>

<div class="footer">Source · <a href="https://pulitzercenter.org/fr/stories/madagascar-terrain-dentrainement-de-lia">Pulitzer Center — Madagascar, terrain d'entraînement de l'IA</a> · Eugénie Baccot / Le Temps</div>

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

Les deux s'appliquent dès que des données sur des **personnes physiques** sont traitées, qu'elles soient citoyen·ne·s, employé·e·s ou technicien·ne·s.


</div>

<div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem; margin-bottom: 0.8rem;">

**Droits des personnes concernées**

- Accès à leurs données
- Rectification des erreurs
- Suppression ("droit à l'oubli")
- Portabilité (recevoir ses données dans un format standard)
- Opposition à certains traitements

</div>

<div style="background: #fef2f2; border: 1px solid #C1002A; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-information style="color: #C1002A;" /> Dans votre projet</div>
  Les noms et contacts des technicien·ne·s sont des données personnelles. Leur traitement est encadré par la nLPD.
</div>

</div>

</div>

<div class="footer">Source · <a href="https://www.fedlex.admin.ch/eli/cc/2022/491/fr">nLPD — fedlex.admin.ch</a> · <a href="https://eur-lex.europa.eu/legal-content/FR/TXT/?uri=CELEX:32016R0679">RGPD — eur-lex.europa.eu</a></div>

---
layout: default
---

# Privacy by design

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

**Privacy by design** : intégrer la protection des données **dès la conception**, pas en réaction à un incident.


- Collecter **seulement ce qui est nécessaire** (minimisation des données)
- Définir une **durée de rétention** et supprimer après expiration
- **Chiffrer** les données sensibles au repos et en transit
- Limiter l'accès au **strict nécessaire** (principe du moindre privilège, déjà vu au cours 06)
- **Documenter** quelles données sont traitées, pour quoi et par qui


</div>

<div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem; margin-bottom: 0.8rem;">
  <div style="font-weight: 600; margin-bottom: 0.2rem;">Ce que ça implique pour l'infrastructure</div>
  <ul style="padding-left: 1rem; margin: 0.3rem 0 0 0;">
    <li>Logs d'audit (qui a accédé à quoi, quand)</li>
    <li>Politique de rétention automatisée (purge après N ans)</li>
    <li>Pseudonymisation ou anonymisation des données de test</li>
    <li>Localisation des données (pas transférer hors UE/CH sans cadre)</li>
  </ul>
</div>

<div style="background: #fffbe6; border: 1px solid #f0d060; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem;">
  <carbon-warning-alt style="color: #c8a000;" /> La conformité n'est pas une case à cocher. C'est un processus continu intégré dans l'architecture.
</div>

</div>

</div>

<div class="footer">Source · <a href="https://www.edoeb.admin.ch/edoeb/fr/home/datenschutz/grundlagen/datenschutz-durch-technik.html">PFPDT — Privacy by Design</a></div>

---
layout: default
---

# Gouvernance des données

<div class="mt-4" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; font-size: 0.84rem;">

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-catalog style="color: #666;" /> Catalogue de données</div>
  Documenter quelles données existent, où elles sont, qui en est responsable, quelle qualité est garantie
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-task style="color: #666;" /> Registre des traitements</div>
  Obligatoire sous nLPD pour les organisations traitant des données sensibles à grande échelle
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-user-access style="color: #666;" /> Contrôle d'accès granulaire</div>
  Qui peut voir quoi, avec quel rôle : le travail fait en cours 06 est exactement ça
</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-recycle style="color: #666;" /> Cycle de vie des données</div>
  Définir quand et comment les données sont archivées, anonymisées ou supprimées
</div>

</div>

<div class="accent-box mt-4">

La gouvernance n'est pas réservée aux grandes entreprises. Même un projet de service communal traitant des noms et des positions GPS a des obligations.

</div>

---
layout: section
---

# Questions ouvertes

---
layout: default
---

# Pour l'ingénieure et l'ingénieur de données

<div class="mt-4" style="font-size: 0.88rem;">

Ces questions n'ont pas de réponse unique. Elles font partie du travail.

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

# Récapitulatif du semestre

<div class="mt-4" style="font-size: 0.85rem;">


1. **Introduction et fondamentaux** : CRUD, ACID, modélisation relationnelle, OLTP vs OLAP
2. **Import et nettoyage** : staging, TRIM, COALESCE, regexp_replace, dédoublonnage
3. **Transactions et concurrence** : niveaux d'isolation, verrous, deadlocks
4. **Optimisation et indexation** : EXPLAIN ANALYZE, B-tree, GIN, GiST
5. **Sécurité, rôles et sauvegarde** : GRANT/REVOKE, principe du moindre privilège, pg_dump
6. **Structures et flux de données** : NoSQL, JSONB, ETL/ELT, triggers, CDC, dbt
7. **Architectures modernes** : Data mesh, Medallion, Lakehouse, RAG
8. **Éthique et durabilité** : impact environnemental, biais, Data Feminism, RGPD/nLPD


</div>

<div class="accent-box mt-4">

Une infrastructure de données n'est pas qu'un problème technique. C'est un système sociotechnique avec des conséquences réelles sur des personnes réelles.

</div>

---
layout: default
---

# Ressources

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

### Livres

- **Data Feminism** — D'Ignazio & Klein (2020)
  <br><small>MIT Press — <a href="https://data-feminism.mitpress.mit.edu/">accès libre en ligne</a></small>

- **Atlas of AI** — Crawford (2021)
  <br><small>Yale University Press</small>

- **Data Mesh** — Dehghani (2022)
  <br><small>O'Reilly Media</small>

- **Designing Data-Intensive Applications** — Kleppmann (2017)
  <br><small>O'Reilly Media</small>

</div>

<div>

### En ligne

- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html) — martinfowler.com
- [Medallion Architecture](https://www.databricks.com/glossary/medallion-architecture) — Databricks
- [Gender Shades](http://gendershades.org/) — Buolamwini & Gebru
- [Machine Bias](https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing) — ProPublica
- [Enjeux et perspectives pour une IA éthique et durable](https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr) — Annales des Mines n°29 (2025)
- [Explained: Generative AI's environmental impact](https://news.mit.edu/2025/explained-generative-ai-environmental-impact-0117) — MIT News (2025)
- [MIT GenAI Impact Paper](https://mit-genai.pubpub.org/pub/8ulgrckc/release/2) — MIT (2025)
- [PFPDT — Protection des données](https://www.edoeb.admin.ch/) — edoeb.admin.ch

</div>

</div>

---
layout: end
---

# Questions ?
