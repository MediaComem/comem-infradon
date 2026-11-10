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

- JSONB, index GIN, vues matérialisées
- Familles NoSQL, CAP, BASE
- OLTP, OLAP, ETL et ELT
- Entrepôt, lac, lakehouse, data mesh
- Over-engineering et grille de décision

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-leaf /></template>
Gouverner une infrastructure : qualité mesurée, conformité nLPD, empreinte environnementale, souveraineté et biais.
</Card>

---
layout: section
---

# Gouvernance

---
layout: grid
cols: 2
align: stretch
content: center
---

# Gouvernance des données

<Card title="Catalogue" footer="cours 05 · lakehouse, data mesh">
<template #icon><pixelarticons-book-open /></template>
Quelles données, où, pour quelle finalité, sous quelle responsabilité.
</Card>
<Card title="Qualité" footer="cours 02 · six dimensions">
<template #icon><pixelarticons-check-double /></template>
Des indicateurs mesurés en continu, avec un seuil et un·e responsable.
</Card>
<Card title="Contrôle d'accès" footer="cours 04 · rôles et privilèges">
<template #icon><pixelarticons-lock /></template>
<code>GRANT</code>, <code>REVOKE</code>, moindre privilège, revue des rôles.
</Card>
<Card title="Cycle de vie" footer="cours 04 · suppression">
<template #icon><pixelarticons-recycle /></template>
Rétention, pseudonymisation, suppression.
</Card>

Une gouvernance se vérifie : chaque règle doit pouvoir s'écrire en requête.

---
layout: section
---

# Qualité des données

---
layout: two-cols
references: "Dehghani, <em>Data Mesh</em>, ch. 3 (2022)"
---

::title::
# De la correction à la mesure

::left::

- Cours 02 : **corriger** les données à l'import
- Ici : **mesurer** la qualité à chaque chargement
- Indicateur = requête + seuil + responsable
- Résultats publiés avec les données
- Dégradation visible avant qu'une décision en dépende

::right::

<Card title="Contrat de données" footer="cours 05 · data mesh">
<template #icon><pixelarticons-clipboard-note /></template>
Le producteur s'engage sur le schéma, la fraîcheur et les seuils de qualité. Le consommateur sait ce qu'il reçoit.
</Card>

<Card color="#d97706" tag="warning" title="Qualité et droit">
<template #icon><pixelarticons-alert /></template>
L'exactitude des données personnelles est une obligation de la nLPD, art. 6 al. 5.
</Card>

---
layout: default
---

# Indicateurs de qualité

| Dimension | Indicateur | Condition SQL |
|---|---|---|
| Complétude | Signalements sans urgence | `urgence IS NULL` |
| Validité | Urgence hors des valeurs admises | `urgence NOT BETWEEN 1 AND 3` |
| Cohérence | Résolu sans date de traitement | `statut = 'résolu' AND traite_le IS NULL` |
| Unicité | Signalements importés deux fois | `GROUP BY ... HAVING count(*) > 1` |
| Temporalité | Ouverts depuis plus d'un an | `cree_le < now() - interval '1 year'` |
| Précision | Écart avec une inspection terrain | Comparaison avec une source de référence |

---
layout: two-cols
---

::title::
# Tableau de qualité

::left::

| Indicateur | Valeur | Seuil |
|---|---|---|
| Sans urgence | 3.9 % | < 1 % |
| Résolu sans date | 3.1 % | 0 % |

- Une vue : recalculée à chaque lecture
- Seuil dépassé : alerte au responsable
- Historiser les valeurs pour voir la tendance

::right::

```sql
CREATE VIEW tableau_qualite AS
SELECT
  round(100.0 * count(*) FILTER (
    WHERE urgence IS NULL) / count(*), 1)
    AS pct_sans_urgence,
  round(100.0 * count(*) FILTER (
    WHERE statut = 'résolu'
      AND traite_le IS NULL) / count(*), 1)
    AS pct_resolu_sans_date
FROM signalement;
```

---
layout: section
---

# nLPD et RGPD

---
layout: two-cols
references:
  - "nLPD, fedlex.admin.ch"
  - "RGPD, eur-lex.europa.eu"
  - "LPrD, Canton de Vaud"
---

::title::
# Cadre légal

::left::

- **RGPD** : Union européenne, 2018
- **nLPD** : Suisse, 2023, personnes privées et Confédération
- **LPrD** : Vaud, pour le canton et les communes
- Données de toute personne physique identifiable

<Card color="#6b7280" tag="note" title="Au Service technique">
<template #icon><pixelarticons-user /></template>
Auteur·rice·s des signalements, technicien·ne·s, positions des véhicules.
</Card>

::right::

### Droits des personnes

- Accès à leurs données
- Rectification
- Effacement
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
- Adresse IP, identifiant
- Position GPS, horodatage

::right::

### Sensibles

- Santé, handicap, sphère intime
- Origine, opinions religieuses ou politiques
- Biométrie, génétique
- Poursuites pénales, aide sociale
- RGPD : traitement **interdit par défaut**

<Card color="#d97706" tag="warning" title="Texte libre">
<template #icon><pixelarticons-alert /></template>
Un champ <code>description</code> peut contenir des données sensibles sans que le schéma le prévoie.
</Card>

---
layout: default
references: "nLPD, art. 6"
---

# Principes de traitement

| Principe | Question pour l'infrastructure |
|---|---|
| Finalité | Pourquoi cette colonne existe-t-elle ? |
| Proportionnalité | La finalité exige-t-elle cette précision ? |
| Durée limitée | Quand la ligne est-elle supprimée ou anonymisée ? |
| Exactitude | Qui corrige une donnée fausse ? |
| Sécurité | Qui peut lire, modifier, exporter ? |
| Transparence | La personne sait-elle ce qui est collecté ? |

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
Journaux d'audit. Purge automatique. Données de test pseudonymisées. Localisation en Suisse ou dans l'UE.
</Card>

<Card color="#d97706" tag="warning" title="Processus continu">
<template #icon><pixelarticons-reload /></template>
La conformité n'est pas une case à cocher : elle s'intègre à l'architecture.
</Card>

---
layout: two-cols
---

::title::
# Audit de conformité

::left::

1. **Inventorier** les colonnes et le texte libre
2. **Qualifier** : personnelle, sensible, aucune
3. **Justifier** chaque donnée par une finalité
4. **Vérifier** accès, rétention, localisation
5. **Documenter** dans le catalogue et le registre

::right::

```sql
-- Toutes les colonnes de la base
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public';

-- Qui peut lire quoi
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public';
```

---
layout: two-cols
references:
  - "nLPD, art. 12"
  - "OPDo, art. 24"
---

::title::
# Registre des traitements

::left::

- Une ligne par **traitement**, pas par table
- Finalité, personnes concernées, catégories de données
- Destinataires, durée de conservation, localisation
- Mesures de sécurité
- Exemption possible sous 250 personnes si le risque est faible

::right::

| Champ | Suivi GPS des véhicules |
|---|---|
| Finalité | Planifier les tournées |
| Personnes | Technicien·ne·s |
| Données | Position toutes les 5 min |
| Durée | ? |
| Accès | ? |

---
layout: two-cols-bottom
references:
  - "RGPD, art. 4 et considérant 26"
  - "Sweeney, <em>Simple Demographics Often Identify People Uniquely</em> (2000)"
---

::title::
# Pseudonymisation et anonymisation

::left::

### Pseudonymisation

- Identifiant remplacé par un code
- Réversible avec une clé ou une table
- Reste une donnée **personnelle**

::right::

### Anonymisation

- Lien avec la personne impossible
- Sort du champ de la nLPD
- Agréger : jour plutôt qu'heure, quartier plutôt qu'adresse

::bottom::

<Card color="#d97706" tag="warning" title="Réidentification">
<template #icon><pixelarticons-search /></template>
Code postal, date de naissance et genre suffisent à identifier 87 % de la population américaine. Supprimer le nom ne suffit pas.
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
class: compact
references:
  - "Google (2009, 2025)"
  - "<a href='https://epoch.ai/gradient-updates/how-much-energy-does-chatgpt-use'>Epoch AI</a> (2025)"
  - "<a href='https://impactco2.fr/outils/usagenumerique/email'>ADEME</a>"
  - "<a href='https://www.delltechnologies.com/asset/en-us/products/servers/briefs-summaries/poweredge-r760-life-cycle-assessment.pdf'>Dell</a>"
---

# Ordres de grandeur

| Usage | Énergie | Émissions | Source |
|---|---|---|---|
| Recherche Google, 2009 | 0.3 Wh | ~0.2 g CO₂ | Google |
| Requête ChatGPT, 2025 | ~0.3 Wh | Non publié | OpenAI, Epoch AI |
| Requête Gemini, 2025, médiane | 0.24 Wh | 0.03 g CO₂e | Google |
| Email | | 0.1 à 2.5 g CO₂e | ADEME |
| Serveur, cycle de vie complet | | 1.4 à 10 t CO₂e, ~10 % fabrication | Dell |

<Card color="#6b7280" tag="note" title="Mix électrique">
<template #icon><pixelarticons-zap /></template>
Grammes = énergie × intensité du réseau. La même requête émet moins sur le réseau suisse. Chiffres déclarés par les entreprises, non audités.
</Card>

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
- Zurich : 114 000 m², environ 16 terrains de football
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
layout: two-cols
---

::title::
# Sobriété des données

::left::

- Chaque ligne gardée est stockée, sauvegardée, répliquée
- Sauvegardes : cours 04, × le nombre de copies
- Index et vues matérialisées : cours 05
- Rétention courte : moins de volume, moins de risque
- Mesurer avant d'acheter du stockage

::right::

```sql
SELECT relname,
  pg_size_pretty(
    pg_total_relation_size(relid))
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;
```

<Card title="Double gain" color="#16a34a" tag="tip">
<template #icon><pixelarticons-trash /></template>
Une donnée inutile coûte deux fois : en énergie et en exposition légale.
</Card>

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

# Biais

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
  - "D'Ignazio et Klein, <em>Data Feminism</em>, ch. 4 (2020)"
  - "W3C, <em>Personal names around the world</em>"
---

::title::
# Biais dans le schéma

::left::

- `genre CHECK (genre IN ('H', 'F'))` : deux cases seulement
- `nom NOT NULL`, `prenom NOT NULL` : un seul modèle de nom
- `adresse NOT NULL` : pas de place sans domicile
- `email NOT NULL` : la fracture numérique exclut
- Catégories fermées : sans case, pas d'existence

::right::

<Card title="À retenir" color="#e92528">
<template #icon><pixelarticons-table /></template>
Une contrainte de schéma est une décision sur qui peut être enregistré·e.
</Card>

<Card color="#6b7280" tag="note" title="Absence">
<template #icon><pixelarticons-eye-closed /></template>
Un <code>NULL</code> lu comme zéro transforme « non mesuré » en « aucun problème ».
</Card>

---
layout: two-cols
references: "Crawford, <em>The Hidden Biases in Big Data</em>, Harvard Business Review (2013)"
---

::title::
# Biais de signalement

::left::

- **Street Bump**, Boston, 2012 : nids-de-poule détectés par smartphone
- Plus de signalements dans les quartiers aisés
- Ce qui est signalé n'est pas ce qui est cassé
- Le canal choisi filtre la population entendue

::right::

<Card color="#d97706" tag="warning" title="Au Service technique">
<template #icon><pixelarticons-map-pin /></template>
« Priorité aux quartiers les plus signalés » favorise les quartiers qui utilisent l'application.
</Card>

<Card title="Correction" color="#16a34a" tag="tip">
<template #icon><pixelarticons-check-double /></template>
Rapporter à la population, comparer à une inspection terrain, suivre la part de chaque canal.
</Card>

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
layout: default
---

# Récapitulatif du semestre

| # | Cours | Notions |
|---|---|---|
| 01 | Introduction | Composants, déploiement, Docker, Git |
| 02 | Import et nettoyage | Qualité, staging, nettoyage SQL, idempotence |
| 03 | Transactions et concurrence | ACID, isolation, MVCC, verrous, coût sous charge |
| 04 | Sécurité, rôles et sauvegarde | `GRANT`, moindre privilège, `pg_dump` |
| 05 | Structures et architectures | JSONB, NoSQL, OLAP, lakehouse, data mesh |
| 06 | Éthique des données | Qualité mesurée, nLPD, empreinte, biais |

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

### Déroulé

1. Inventaire et registre : 60 min
2. Minimisation et rétention : 45 min
3. Indicateurs de qualité : 45 min
4. Biais et question type : 30 min

<Card color="#6b7280" tag="note" title="Non noté">
<template #icon><pixelarticons-book-open /></template>
Les exercices préparent l'examen final.
</Card>

::right::

### Départ

1. Télécharger [06-service-technique.sql](https://comem-infradon.onrender.com/exercices/06-service-technique.sql), données fictives
2. Le copier dans le dossier `data`
3. L'exécuter dans `psql`, base `yverdon`

```sql
\i /data/06-service-technique.sql
```

---
layout: two-cols
references: "PostgreSQL, <em>COMMENT</em>, <em>information_schema</em>"
---

::title::
# Syntaxe : catalogue

::left::

- `information_schema.columns` : toutes les colonnes
- `COMMENT ON` : documenter dans la base
- `col_description` : lire un commentaire
- `\d+ table` dans `psql` : colonnes et commentaires

::right::

```sql
COMMENT ON COLUMN table_name.column_name
  IS 'Personnelle. Finalité : ...';

SELECT table_name, column_name,
       col_description(
         table_name::regclass,
         ordinal_position) AS commentaire
FROM information_schema.columns
WHERE table_schema = 'public';
```

---
layout: two-cols
references: "PostgreSQL, <em>Aggregate Expressions</em>"
---

::title::
# Syntaxe : agrégat filtré

::left::

- `FILTER (WHERE ...)` : compter un sous-ensemble
- Plusieurs indicateurs en une seule lecture
- `100.0 *` : division décimale, pas entière

::right::

```sql
SELECT
  count(*) AS total,
  count(*) FILTER (
    WHERE condition) AS nb_anomalies,
  round(100.0 * count(*) FILTER (
    WHERE condition) / count(*), 1)
    AS pct_anomalies
FROM table_name;
```

---
layout: two-cols
references: "PostgreSQL, <em>Binary String Functions</em>"
---

::title::
# Syntaxe : pseudonymisation

::left::

- `sha256` : même entrée, même code
- **Sel** secret : empêche de retrouver un email connu
- Vue publique : seulement les colonnes utiles
- Accès à la vue, pas à la table

::right::

```sql
SELECT encode(sha256(convert_to(
         'sel-secret' || email, 'UTF8')),
       'hex') AS auteur
FROM table_name;

CREATE VIEW vue_publique AS
SELECT id, cree_le::date AS jour, ...
FROM table_name;

REVOKE SELECT ON table_name FROM role_name;
GRANT SELECT ON vue_publique TO role_name;
```

---
layout: two-cols
references: "PostgreSQL, <em>VACUUM</em>, <em>Database Object Size Functions</em>"
---

::title::
# Syntaxe : purge et taille

::left::

- `pg_total_relation_size` : table, index et TOAST
- `DELETE` dans une transaction : vérifier avant `COMMIT`
- `VACUUM FULL` : réécrit la table, la verrouille

::right::

```sql
SELECT pg_size_pretty(
  pg_total_relation_size('table_name'));

BEGIN;
DELETE FROM table_name
WHERE horodatage < now() - interval '1 year';
-- Vérifier le nombre de lignes supprimées
COMMIT;

VACUUM FULL table_name;
```

---
layout: two-cols-bottom
---

::title::
# Exercice 1 : inventaire

::left::

### Étapes

1. Lister les colonnes des tables
2. Classer chaque colonne : personnelle, sensible, aucune
3. Chercher des données sensibles dans `description`
4. Documenter les colonnes personnelles : `COMMENT ON`
5. Lister les privilèges des deux rôles

::right::

```sql
SELECT description, count(*)
FROM signalement
GROUP BY description
ORDER BY count(*);

SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('stagiaire',
                  'portail_public');
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Quelle colonne poserait le plus de problèmes en cas de fuite ? Quel rôle a trop de droits ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 2 : registre des traitements

::left::

### Étapes

1. Identifier trois traitements dans la base
2. Remplir `registre_traitements`, une ligne par traitement
3. Fixer une durée de conservation pour chacun
4. Noter les colonnes qu'aucune finalité ne justifie

::right::

```sql
INSERT INTO registre_traitements VALUES (
  'Suivi GPS des véhicules',
  'Planifier les tournées',
  'Technicien·ne·s',
  'Position et heure, toutes les 5 min',
  'Responsable du Service technique',
  '...',
  '...'
);
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Une position toutes les 5 minutes depuis 2019 est-elle proportionnée à la planification des tournées ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 3 : minimisation et rétention

::left::

### Étapes

1. Créer `signalement_public` sans les colonnes d'auteur·rice
2. Donner à `portail_public` la vue, pas la table
3. Mesurer la taille de `position_gps`
4. Purger selon la durée de l'exercice 2, dans une transaction
5. Mesurer à nouveau, puis après `VACUUM FULL`

::right::

```sql
SELECT count(*)
FROM position_gps AS p
JOIN technicien AS t
  ON t.id = p.technicien_id
WHERE t.parti_le IS NOT NULL;
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Pourquoi la taille ne baisse-t-elle pas après le <code>DELETE</code> ? Rappel du cours 03, MVCC.
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 4 : indicateurs de qualité

::left::

### Étapes

1. Une requête par dimension : complétude, validité, cohérence, unicité, temporalité
2. Ajouter : lignes hors rétention, colonnes non documentées
3. Regrouper le tout dans une vue `tableau_qualite`
4. Fixer un seuil par indicateur

::right::

| indicateur | valeur | seuil |
|---|---|---|
| sans urgence | | |
| urgence invalide | | |
| résolu sans date | | |
| doublons | | |
| ouverts > 1 an | | |

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Qui est responsable de chaque indicateur ? Lesquels se corrigent à la source, lesquels en aval ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 5 : biais de signalement

::left::

### Étapes

1. Compter les signalements 2026 par quartier
2. Les rapporter à 1000 habitants
3. Calculer la part de chaque canal par quartier
4. Comparer avec la table `inspection`

::right::

> « Le budget d'entretien 2027 va en priorité aux quartiers les plus signalés. »

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Quel quartier cette règle désavantage-t-elle, et pourquoi ? Quel indicateur utiliser à la place ?
</Card>

---
layout: two-cols
---

::title::
# Exercice 6 : question type

::left::

### Situation

> « Inscriptions aux ateliers numériques pour les seniors de la commune. »

### Question

Relever deux problèmes de conformité et deux biais induits par ce schéma. Proposer une correction.

::right::

```sql
CREATE TABLE inscription_atelier (
  id             serial PRIMARY KEY,
  nom            text NOT NULL,
  prenom         text NOT NULL,
  genre          char(1) NOT NULL
                 CHECK (genre IN ('H', 'F')),
  date_naissance date NOT NULL,
  adresse        text NOT NULL,
  email          text NOT NULL,
  -- allergies, handicap
  remarques      text
);

GRANT SELECT ON inscription_atelier
  TO PUBLIC;
```

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

- [PFPDT, protection des données](https://www.edoeb.admin.ch/)
- [nLPD, texte de loi](https://www.fedlex.admin.ch/eli/cc/2022/491/fr)
- [Machine Bias](https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing), ProPublica
- [The Hidden Biases in Big Data](https://hbr.org/2013/04/the-hidden-biases-in-big-data), HBR
- [Generative AI's environmental impact](https://news.mit.edu/2025/explained-generative-ai-environmental-impact-0117), MIT News

---
layout: section
---

# Questions
