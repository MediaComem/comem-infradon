---
theme: pixel
number: "06"
title: "Éthique des données"
subtitle: "Infrastructure de Données"
author: "Noemi Romano"
email: "noemi.romano@heig-vd.ch"
github: "https://github.com/MediaComem/comem-infradon"
breadcrumb: "Infrastructure de Données"
logos:
  - /images/logo-heig-vd.svg
  - src: /images/logo-hes-so.png
    height: 79px

download: true
mdc: true
layout: cover
---

---
layout: default
---

# Cours précédent

- JSONB, index GIN et GiST, `EXPLAIN ANALYZE`
- Familles NoSQL et choix d'une structure
- CAP, BASE, OLTP et OLAP
- ETL, ELT, entrepôt, lac, lakehouse
- Data mesh et gouvernance fédérée

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-leaf /></template>
Ce que coûte une infrastructure de données : matériaux, énergie, biais, souveraineté, protection des données.
</Card>

---
layout: section
---

# Industrie extractive

---
layout: two-cols
references:
  - "Crawford, <em>Atlas of AI</em> (2021)"
  - "IEA, <em>Electricity 2024</em>"
---

::title::
# Coût d'une infrastructure

::left::

- **Serveurs** : électricité jour et nuit
- **Eau** : refroidissement
- **Matériaux rares** : lithium, cobalt
- **Bâtiments** : hébergement
- **Câbles sous-marins** : connectivité mondiale

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/06/ia-environnement.png"
  caption="Emily Yee, <a href='https://whitmanwire.com/science-environment/2024/10/03/the-environmental-impact-of-data-centers-balancing-ai-growth-and-energy-infrastructure-in-eastern-washington/'>Whitman Wire</a> (2024)"
  alt="Illustration de l'impact environnemental des datacenters"
/>

---
layout: two-cols
references:
  - "Crawford, <em>Atlas of AI</em>, ch. 1 (2021)"
  - "Pitron, Reporterre"
---

::title::
# Lithium et cobalt

::left::

- Lithium : Chili, Argentine, Bolivie
- Des millions de litres d'eau par jour
- Plus de 60% du cobalt mondial : RDC
- Mineur·euse·s sans protection, enfants compris
- Revenus captés loin des communautés

::right::

<Figure
  src="/images/06/reporterre.webp"
  caption="Sanaga, <a href='https://reporterre.net/Guillaume-Pitron-Un-telephone-portable-ne-pese-pas-150-grammes-mais-150-kilos'>Reporterre, G. Pitron</a>"
  alt="Illustration de Reporterre sur le poids réel d'un téléphone"
/>

---
layout: default
---

# Matériaux dans l'infrastructure

| Composant | Matériau |
|---|---|
| Batteries de secours des datacenters | Lithium |
| Puces, SSD, cartes réseau | Cobalt |
| Ordinateurs et téléphones des équipes | Lithium et cobalt |
| Câbles sous-marins | Terres rares |

---
layout: section
---

# Énergie et carbone

---
layout: two-cols
references:
  - "IEA (2024)"
  - "Climatiq (2024)"
  - "MIT News (2025)"
---

::title::
# Empreinte carbone du numérique

::left::

- Numérique : **~4%** des émissions de CO₂
- Datacenters seuls : **~1%**, en forte croissance
- Fabrication souvent supérieure à l'exploitation

::right::

<Figure
  src="/images/06/cloud-emission.jpg"
  caption="<a href='https://www.climatiq.io/blog/measure-greenhouse-gas-emissions-carbon-data-centres-cloud-computing'>Climatiq, <em>Measuring GHG emissions from cloud</em></a> (2024)"
  alt="Émissions du cloud"
/>

---
layout: default
references:
  - "IEA (2024)"
  - "Climatiq (2024)"
  - "MIT News (2025)"
---

# Ordres de grandeur

| Usage | Émissions |
|---|---|
| Recherche Google | ~0.3 g CO₂ |
| Requête ChatGPT | ~0.15 g CO₂ |
| Email sans pièce jointe | ~4 g CO₂ |
| Email avec pièce jointe | ~50 g CO₂ |
| Fabrication d'un serveur | Plusieurs tonnes de CO₂ |

---
layout: two-cols
references:
  - "swissinfo.ch (2026)"
  - "ETH Zurich"
  - "OFEN (2021)"
---

::title::
# Datacenters en Suisse

::left::

- **6 à 8%** de l'électricité suisse, 3% au niveau mondial
- **10 à 15%** d'ici 2030 selon la HSLU
- **+4,6 TWh** nécessaires selon l'ETH Zurich
- ~120 datacenters, parmi les plus fortes densités
- Plus de 10 nouveaux sites en construction

::right::

<Figure
  src="/images/06/data-centers-switzerland.png"
  caption="<a href='https://www.datacentermap.com/switzerland/'>datacentermap.com</a>"
  alt="Carte des datacenters en Suisse"
/>

---
layout: default
references:
  - "swissinfo.ch (2026)"
  - "AlgorithmWatch CH"
---

# Tensions et attentes

- Réseau haute tension zurichois déjà à la limite
- Migration vers Argovie et Schaffhouse
- Canton de Zurich : 114 000 m², environ 16 terrains de football
- **72%** de la population : énergie 100% renouvelable
- **80%** : plus de transparence sur la consommation

---
layout: two-cols
references: "RTS (2026)"
---

::title::
# Crainte ou opportunité

::left::

### Opportunité

- Emplois qualifiés, attractivité
- Revenus fiscaux pour les cantons
- Exportation de services numériques

::right::

### Crainte

- Pression sur le réseau électrique
- Consommation d'eau
- Conflit avec les objectifs climatiques
- Opacité sur la consommation réelle

---
layout: default
---

# Expansion des datacenters

<Figure
  class="w-2/3 mx-auto framed"
  src="/images/06/rts-datacenters.png"
  caption="RTS Forum, <em>L'expansion des datacenters en Suisse interroge</em> (2026)"
  href="https://www.rts.ch/info/economie/2026/article/entre-crainte-ecologique-et-opportunite-economique-l-expansion-des-datacenters-en-suisse-interroge-29235422.html"
  alt="Article RTS sur l'expansion des datacenters en Suisse"
/>

---
layout: photowall
images:
  - src: "/images/06/heil-vernier.jpg"
    caption: "Equinix GV2, Vernier (GE), 2009"
    href: "https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace"
  - src: "/images/06/heil-montbrillant.jpg"
    caption: "Swisscom Geneva-Montbrillant, 1983"
    href: "https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace"
  - src: "/images/06/heil-montbenon.jpg"
    caption: "Swisscom Lausanne-Montbenon, 2014"
    href: "https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace"
  - src: "/images/06/heil-gland.jpg"
    caption: "Stack GEN02, Gland (VD), 2017 · Photos Julien Heil, espazium.ch (2026)"
    href: "https://www.espazium.ch/fr/actualites/invisibles-les-data-centers-dans-lespace"
---

---
layout: grid
cols: 4
align: stretch
content: center
references: "<a href='https://www.infomaniak.com/fr/ecologie'>infomaniak.com/fr/ecologie</a>"
---

# Infomaniak

<Card title="Énergie">
<template #icon><pixelarticons-zap /></template>
60% hydraulique, 40% solaire. Objectif 100% renouvelable atteint.
</Card>
<Card title="Compensation">
<template #icon><pixelarticons-leaf /></template>
200% des émissions : fabrication, électricité, transport, vols.
</Card>
<Card title="Chaleur">
<template #icon><pixelarticons-fire /></template>
D4 : 100% de la chaleur fatale injectée dans le chauffage à distance.
</Card>
<Card title="Durée de vie">
<template #icon><pixelarticons-clock /></template>
Serveurs utilisés <strong>15 ans</strong> au lieu de 7 à 10. ISO 14001, ISO 50001.
</Card>

---
layout: image-full
image: /images/06/infomaniak-nous-polluons.png
caption: "<strong>Infomaniak</strong><br>infomaniak.com/fr/ecologie"
href: "https://www.infomaniak.com/fr/ecologie"
---

---
layout: section
---

# Biais

---
layout: two-cols
references: "Noble, <em>Algorithms of Oppression</em> (2018)"
---

::title::
# Sources et conséquences des biais

::left::

### Sources

- Historique discriminatoire pris pour vérité
- Optimiser l'engagement favorise l'extrême
- Prédictions qui influencent ce qu'elles mesurent
- Variables incluses ou ignorées

::right::

### Conséquences

- Discrimination systématique, à grande échelle
- Décisions automatisées sans explication
- Difficile à contester : boîte noire

---
layout: two-cols
references: "ProPublica, <em>Machine Bias</em> (2016)"
---

::title::
# Cas COMPAS

::left::

- Score de risque de récidive, de 1 à 10
- Utilisé par des tribunaux américains
- Enquête ProPublica sur 7 000 personnes
- Faux positifs **2 fois** plus fréquents pour les personnes racisées
- Variables corrélées au phénotype

::right::

<Figure
  src="/images/06/propublica-risk.png"
  caption="<a href='https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing'>ProPublica, <em>Machine Bias</em></a> (2016)"
  alt="Scores de risque COMPAS selon ProPublica"
/>

---
layout: two-cols
references:
  - "D'Ignazio et Klein, <em>Data Feminism</em> (2020)"
  - "Crawford, <em>Atlas of AI</em> (2021)"
---

::title::
# Données et neutralité

::left::

- Qui décide **quoi collecter** ?
- Qui est **représenté** dans les données ?
- Qui **bénéficie** de l'analyse ?
- Qui **supporte** le coût de l'infrastructure ?
- Qui est **exclu** ou rendu invisible ?

<Card title="À retenir" color="#e92528">
<template #icon><pixelarticons-alert /></template>
L'infrastructure encode des priorités, des valeurs et des rapports de pouvoir.
</Card>

::right::

<Figure
  class="w-1/2 mx-auto"
  src="/images/01/Data_Feminism.jpg"
  href="https://data-feminism.mitpress.mit.edu/"
  alt="Couverture de Data Feminism"
/>

---
layout: section
---

# Fin de vie

---
layout: two-cols
references:
  - "Crawford, <em>Atlas of AI</em> (2021)"
  - "Data Centre Magazine (2024)"
  - "ETH Zurich CSS, <em>Mind the E-Waste</em> (2023)"
---

::title::
# Déchets électroniques

::left::

- Matériel des datacenters remplacé tous les 3 à 5 ans
- La demande en IA accélère ce rythme
- Plomb, mercure, cadmium en décharge
- **80%** des e-déchets vers des pays à bas revenus
- Recycleur·euse·s exposé·e·s sans protection

::right::

<Card title="Recommandations" color="#16a34a" tag="tip">
<template #icon><pixelarticons-recycle /></template>
Concevoir pour la <strong>longévité</strong>. Rendre la fin de vie des équipements transparente.
</Card>

<Figure
  src="https://css.ethz.ch/en/center/CSS-news/2023/08/mind-the-e-waste-a-case-for-switzerland/_jcr_content/par/lead/imagePanorama.imageformat.carousel.1496881384.jpg"
  caption="<a href='https://ethz.ch/content/dam/ethz/special-interest/gess/cis/center-for-securities-studies/pdfs/PP11-3_2023-EN.pdf'>ETH Zurich CSS, <em>Mind the E-Waste</em></a> (2023)"
  alt="Déchets électroniques"
/>

---
layout: section
---

# Souveraineté numérique

---
layout: two-cols
references:
  - "<a href='https://news.infomaniak.com/souverainete-numerique-de-la-suisse/'>Infomaniak, <em>Souveraineté numérique de la Suisse</em></a> (2021)"
  - "RTS (2022)"
---

::title::
# Souveraineté numérique

::left::

- Contrôler ses données sans dépendre de tiers étrangers
- **Données** : où, sous quelle juridiction ?
- **Infrastructure** : qui possède les serveurs ?
- **Logiciels** : open source ou propriétaires ?
- **Cloud Act** (2018) : accès américain, partout

::right::

<Figure
  src="/images/06/contrats-suisse-cloud.png"
  caption="<a href='https://www.rts.ch/info/suisse/13419618-les-contrats-avec-cinq-geants-du-numerique-pour-le-cloud-de-la-confederation-ont-ete-signes.html'>RTS, contrats cloud de la Confédération</a> (2022)"
  alt="Article RTS sur les contrats cloud de la Confédération"
/>

---
layout: two-cols-bottom
references:
  - "RTS (2026)"
  - "Climatiq"
  - "ScienceDirect (2025)"
  - "The Guardian (2026)"
---

::title::
# Cloud externe

::left::

### Pour

- PUE ~1.2 contre ~2.0 en interne
- Infrastructure mutualisée
- Engagements d'énergie renouvelable
- Redondance mondiale

::right::

### Contre

- Cloud Act : accès des autorités américaines
- Dépendance au fournisseur
- Fabrication et fin de vie rarement publiées
- 3 acteurs : ~65% du marché mondial

::bottom::

<Card color="#6b7280" tag="note" title="PUE">
<template #icon><pixelarticons-info-box /></template>
<em>Power Usage Effectiveness</em> : énergie totale du datacenter divisée par l'énergie des serveurs. Idéal : 1.0.
</Card>

---
layout: section
---

# nLPD et RGPD

---
layout: two-cols
references:
  - "nLPD, fedlex.admin.ch"
  - "RGPD, eur-lex.europa.eu"
---

::title::
# Cadre légal

::left::

- **RGPD** : Union européenne, 2018
- **nLPD** : Suisse, 2023
- Données personnelles de toute personne physique
- Citoyen·ne·s, employé·e·s, technicien·ne·s

<Card color="#6b7280" tag="note" title="Dans le projet">
<template #icon><pixelarticons-user /></template>
Les noms et contacts des technicien·ne·s sont des données personnelles.
</Card>

::right::

### Droits des personnes

- Accès à leurs données
- Rectification
- Suppression : droit à l'oubli
- Portabilité dans un format standard
- Opposition à certains traitements

---
layout: two-cols
references:
  - "nLPD, art. 5"
  - "RGPD, art. 9"
---

::title::
# Données personnelles et sensibles

::left::

### Personnelles

- Nom, prénom, adresse
- Email, téléphone
- Adresse IP, cookie
- Position GPS

::right::

### Sensibles

- Santé, handicap
- Origine ethnique
- Convictions religieuses ou politiques
- Biométrie, génétique, orientation sexuelle
- Poursuites pénales

---
layout: two-cols
---

::title::
# nLPD et RGPD : données sensibles

::left::

### nLPD, art. 5 let. c

- Santé, sphère intime, origine
- Opinions religieuses, politiques, syndicales
- Poursuites pénales et administratives
- Mesures d'aide sociale
- Profil de personnalité

::right::

### RGPD, art. 9

- Origine raciale ou ethnique
- Opinions politiques, convictions religieuses
- Données génétiques, biométriques
- Santé, orientation sexuelle
- Traitement **interdit par défaut**

---
layout: two-cols
references: "PFPDT, <em>Privacy by Design</em>"
---

::title::
# Privacy by design

::left::

- Collecter le **strict nécessaire**
- Fixer une **durée de rétention**
- **Chiffrer** au repos et en transit
- Accès au moindre privilège : cours 04
- **Documenter** quoi, pour quoi, par qui

::right::

<Card title="Infrastructure">
<template #icon><pixelarticons-server /></template>
Journaux d'audit. Purge automatique après N années. Données de test pseudonymisées. Localisation en Suisse ou dans l'UE.
</Card>

<Card color="#d97706" tag="warning" title="Processus continu">
<template #icon><pixelarticons-reload /></template>
La conformité n'est pas une case à cocher : elle s'intègre à l'architecture.
</Card>

---
layout: grid
cols: 2
align: stretch
content: center
---

# Gouvernance des données

<Card title="Catalogue" footer="cours 05 · lakehouse, data mesh">
<template #icon><pixelarticons-book-open /></template>
Quelles données, où, sous quelle responsabilité, de quelle qualité.
</Card>
<Card title="Registre des traitements">
<template #icon><pixelarticons-clipboard-note /></template>
Exigé par la nLPD pour les traitements sensibles à grande échelle.
</Card>
<Card title="Contrôle d'accès" footer="cours 04 · rôles et privilèges">
<template #icon><pixelarticons-lock /></template>
<code>GRANT</code>, <code>REVOKE</code>, moindre privilège.
</Card>
<Card title="Cycle de vie" footer="cours 05 · medallion">
<template #icon><pixelarticons-recycle /></template>
Rétention, anonymisation, suppression.
</Card>

Un service communal qui traite des noms et des positions GPS a, lui aussi, des obligations.

---
layout: section
---

# Questions ouvertes

---
layout: grid
cols: 2
align: stretch
content: center
---

# Questions pour le poster

<Card title="Propriété">
<template #icon><pixelarticons-home /></template>
À qui appartiennent les données du mobilier urbain : la commune, les habitant·e·s, le prestataire ?
</Card>
<Card title="Équité">
<template #icon><pixelarticons-scale /></template>
Un banc « prioritaire » dans un quartier défavorisé : résultat équitable ou biais des signalements ?
</Card>
<Card title="Rétention">
<template #icon><pixelarticons-clock /></template>
Combien d'années garder les noms des technicien·ne·s ? Qui décide ?
</Card>
<Card title="Surveillance">
<template #icon><pixelarticons-map-pin /></template>
Suivre les technicien·ne·s par GPS pour optimiser les tournées : quelles questions éthiques ?
</Card>

Au moins une question à analyser dans le poster.

---
layout: default
---

# Récapitulatif du semestre

| # | Cours | Notions |
|---|---|---|
| 01 | Introduction | Composants, déploiement, projet |
| 02 | Import et nettoyage | Qualité, staging, nettoyage SQL, idempotence |
| 03 | Transactions et concurrence | ACID, isolation, MVCC, verrous |
| 04 | Sécurité, rôles et sauvegarde | `GRANT`, moindre privilège, `pg_dump` |
| 05 | Structures et architectures | JSONB, index, NoSQL, ELT, data mesh |
| 06 | Éthique des données | Environnement, biais, souveraineté, nLPD |

<Card title="À retenir" color="#e92528">
<template #icon><pixelarticons-users /></template>
Une infrastructure de données est un système sociotechnique, avec des conséquences réelles sur des personnes réelles.
</Card>

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# Travail pratique · Semaine 6

::left::

### Poster A3, portrait

1. Contexte et périmètre
2. Modèle logique : tables, relations, cardinalités
3. Démarche : décisions, alternatives, difficultés
4. Réflexion éthique : une question ouverte

::right::

<Card title="Présentation" color="#e92528">
<template #icon><pixelarticons-presentation /></template>
Fin du semestre : poster imprimé, affiché en classe, présenté et discuté.
</Card>

<Card title="Rendu final">
<template #icon><logos-github-icon /></template>
Scripts SQL, jalons, adaptations. <code>git clone</code> puis <code>docker compose up -d</code> : base opérationnelle.
</Card>

---
layout: grid
cols: 2
align: stretch
content: center
---

# Contenu du poster

<Card title="Contexte et périmètre">
<template #icon><pixelarticons-flag /></template>
Projet, données sources, contraintes identifiées.
</Card>
<Card title="Modèle logique" footer="zone centrale">
<template #icon><pixelarticons-table /></template>
Tables, relations, cardinalités, contraintes, index, types.
</Card>
<Card title="Démarche">
<template #icon><pixelarticons-git-branch /></template>
Décisions de modélisation, alternatives rejetées, compromis.
</Card>
<Card title="Réflexion éthique" footer="bandeau bas">
<template #icon><pixelarticons-scale /></template>
Une question de ce cours. Gouvernance, nLPD, accès, cycle de vie.
</Card>

---
layout: two-cols
---

::title::
# Ressources

::left::

### Livres

- D'Ignazio et Klein, *Data Feminism* (2020), [accès libre](https://data-feminism.mitpress.mit.edu/)
- Crawford, *Atlas of AI* (2021)
- Dehghani, *Data Mesh* (2022)
- Kleppmann, *Designing Data-Intensive Applications* (2017)

::right::

### En ligne

- [Gender Shades](http://gendershades.org/), Buolamwini et Gebru
- [Machine Bias](https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing), ProPublica
- [Enjeux pour une IA éthique et durable](https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr), Annales des Mines
- [Generative AI's environmental impact](https://news.mit.edu/2025/explained-generative-ai-environmental-impact-0117), MIT News
- [PFPDT, protection des données](https://www.edoeb.admin.ch/)

---
layout: section
---

# Questions
