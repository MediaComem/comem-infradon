---
theme: default
download: true
title: "01 - Introduction"
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
    <h1 class="cover-title">01 — Introduction</h1>
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

# D'où venez-vous ?

---
layout: default
---

# Rappel : le cours de modélisation

Le cours de **Modélisation de données** vous a appris à :

<v-clicks>

- Analyser un problème client pour **identifier les données nécessaires**
- Conceptualiser une solution sous forme d'un **modèle conceptuel** (MCD)
- Traduire le modèle conceptuel en **modèle logique** relationnel (MLD)
- L'implémenter en **modèle physique** (MPD)
- Écrire des requêtes **SQL**

</v-clicks>

<div v-click class="accent-box mt-6">

**Question** : Une fois vos tables créées... que se passe-t-il quand 1000 utilisateurs y accèdent simultanément ?

</div>

---
layout: default
---

# Ce cours : la suite logique

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

- Comprendre les enjeux d'**infrastructure** : concurrence, performance, sécurité, durabilité
- **Importer, nettoyer et transformer** des données brutes en base exploitable
- **Comparer les structures** de données et choisir la plus adaptée
- Concevoir des **pipelines de transformation** (ETL/ELT)
- **Sécuriser, optimiser** et automatiser une infrastructure
- Porter un **regard critique** sur les dimensions éthiques et environnementales

</v-clicks>

</div>

<div class="flex items-center justify-center">

```mermaid {scale: 0.75}
%%{init: {'theme': 'base', 'themeVariables': {'primaryColor': '#f5f5f5', 'primaryTextColor': '#000', 'primaryBorderColor': '#e0e0e0', 'lineColor': '#9e9e9e', 'fontFamily': 'Roboto Mono', 'fontSize': '12px'}, 'flowchart': {'htmlLabels': true, 'useMaxWidth': false}}}%%
graph TB
    A["<div style='min-width:220px;text-align:center;padding:8px'><strong>Modélisation</strong><br/>Quoi stocker</div>"] --> B["<div style='min-width:220px;text-align:center;padding:8px'><strong>Infrastructure</strong><br/>Comment le stocker,<br/>le protéger, le faire évoluer</div>"]
    B --> C["<div style='min-width:220px;text-align:center;padding:8px'><strong>Production</strong><br/>Systèmes réels<br/>avec vrais utilisateurs</div>"]

    style A fill:#f5f5f5,stroke:#e0e0e0,color:#000
    style B fill:#DA291C,stroke:#DA291C,color:#fff
    style C fill:#f5f5f5,stroke:#e0e0e0,color:#000

    linkStyle default stroke:#9e9e9e,stroke-width:2px
```

</div>

</div>

---
layout: default
---

# Zoom arrière : la base de données est un composant

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

- La base de données est **essentielle** mais **pas suffisante**
- Elle coexiste avec des caches, des files d'attente, du stockage objet, des moteurs de recherche
- Chaque composant a ses forces : le bon outil pour le bon usage
- Ce cours se concentre sur la **couche données** — mais en gardant la vue d'ensemble

</v-clicks>

</div>

<div>

<img src="/images/01-introduction/web-app-architecture.png" class="h-64" />
<figcaption><a href="https://www.zealousys.com/blog/web-application-architecture/">Zealous Systems - What is Web Application Architecture: The Complete Guide</a></figcaption>

</div>

</div>

---
layout: section
---

# Les 10 modules du semestre

---
layout: default
---

# Les 10 modules en un coup d'oeil

| Module | Mots-clés |
|---|---|
| 02 · Fondamentaux | CRUD, ACID, OLTP/OLAP, vues |
| 03 · Import et nettoyage | Staging, qualité, nettoyage SQL |
| 04 · Transactions | Isolation, verrous, deadlocks |
| 05 · Optimisation | Plans d'exécution, index |
| 06 · Sécurité et sauvegarde | Rôles, permissions, backup |
| 07 · Structures de données | NoSQL, graph, stockage médias |
| 08 · Flux de données | ETL/ELT, CDC, dbt |
| 09 · Architectures modernes | Data mesh, medallion, RAG |
| 10 · Éthique et durabilité | Environnement, souveraineté |

---
layout: default
---

# Penser l'infrastructure : technique, valeurs et impacts

Tout au long du semestre, nous questionnerons nos décisions techniques :

| Décision | Question |
|---|---|
| **Cloud vs on-premise** | Juridiction ? Souveraineté des données ? |
| **Propriétaire vs open source** | Vendor lock-in ? |
| **Dimensionnement** | Coût énergétique vs coût humain |
| **Rétention** | Que garde-t-on, combien de temps ? |
| **Redondance et backups** | Coût acceptable d'une perte ? |
| **Choix de structure** | Relationnel, NoSQL, graph — quel usage ? |

<div v-click class="accent-box mt-4">

Il n'y a pas de choix neutre. Une infrastructure bien conçue est une infrastructure dont les compromis sont **documentés et assumés**.

</div>

<div class="footer"><a href="https://www.edoeb.admin.ch/fr/protection-des-donnees">nLPD</a> · <a href="https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr">Enjeux et perspectives pour une IA éthique et durable, <em>Annales des Mines</em> n°29, 2025</a></div>

---
layout: section
---

# Organisation du cours

---
layout: default
---

# Supports

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Cours (slides)

[comem-infradon.onrender.com](https://comem-infradon.onrender.com/)

</div>

<div>

### <carbon-logo-github /> GitHub

[github.com/MediaComem/comem-infradon](https://github.com/MediaComem/comem-infradon)

- Description du cours et objectifs
- Données et briefs du projet
- Jalons et évaluation

</div>

</div>

---
layout: default
---

# Évaluation

<img src="/images/evaluation.svg" class="w-full mx-auto mt-4" />

<div class="grid grid-cols-2 gap-8 mt-6">

<div v-click>

### Projet (50%)

- Par groupes de 2-3
- **Poster A3** synthétisant les étapes du projet (affiché en classe)
- Présentation du poster + questions — **28-29 mai**
- Rendu final : scripts, jalons, adaptations — **31 mai**

</div>

<div v-click>

### Examen final (50%)

- Individuel, en semaine d'examen
- Sur ordinateur · 3h
- Mise en situation : un schéma, un cas, un problème — proposer et justifier une solution

</div>

</div>

---
layout: default
---

# Outils et prérequis

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Ce que vous connaissez déjà

<v-clicks>

- <carbon-data-base /> **PostgreSQL** + **PostGIS** — Notre SGBD principal
- <carbon-logo-github /> **Git / GitHub** — Versioning du projet
- <carbon-container-software /> **Docker** — Conteneurisation

</v-clicks>

</div>

<div v-click>

### Ce que nous ajouterons

- <carbon-chart-treemap /> **Index** (B-tree, GIN, GiST) — Optimisation
- <carbon-search /> **EXPLAIN ANALYZE** — Analyse de requêtes
- <carbon-locked /> **Rôles et permissions** — Sécurité
- <carbon-save /> **pg_dump / pg_restore** — Sauvegarde
- <carbon-flow /> **dbt** — Pipelines de transformation

</div>

</div>

---
layout: section
---

# Le projet fil rouge

Service technique communal d'Yverdon-les-Bains

---
layout: default
---

# Le contexte

La personne en charge du Service technique de la Commune d'Yverdon-les-Bains gère depuis 2018 le **mobilier urbain** dans des fichiers Excel : bancs, lampadaires, fontaines, poubelles, bornes de recharge.

<v-clicks>

- Elle note les **signalements** de la population (un banc cassé, un lampadaire éteint)
- Elle enregistre les **interventions** de maintenance
- Elle tient une liste de **fournisseurs** pour commander du matériel

</v-clicks>

<div v-click class="accent-box mt-4">

Vous recevez les **4 fichiers Excel** tels quels. Votre mission : en faire une **infrastructure de données** fonctionnelle, optimisée, et utile.

Les données sont **fictives** — les noms, numéros et coordonnées ont été générés pour les besoins du cours.

</div>

---
layout: default
---

# Les données du Service technique

<div class="grid grid-cols-2 gap-4 mt-4 text-sm">

<div class="p-3 border rounded">

### inventaire_mobilier.xlsx

~120 objets : bancs, lampadaires, fontaines, poubelles, bornes EV

Positions GPS dans la commune d'Yverdon

</div>

<div class="p-3 border rounded">

### signalements.xlsx

~200 signalements de la population et de patrouilles

Dates, descriptions en texte libre, urgence, statut

</div>

<div class="p-3 border rounded">

### interventions.xlsx

~150 interventions de maintenance

Dates, technicien-ne-s, durée, coûts, type d'intervention

</div>

<div class="p-3 border rounded">

### fournisseurs_contacts.xlsx

~15 fournisseurs régionaux

Contacts, spécialités

</div>

</div>

<div v-click class="accent-box mt-4">

Les données sont volontairement **imparfaites** : comme de vrais Excel faits à la main.

</div>

---
layout: default
---

# Un brief par groupe

Chaque groupe reçoit les **mêmes données** mais un **brief différent** :

<div class="grid grid-cols-2 gap-4 mt-4 text-sm">

<div v-click class="p-3 border rounded">

### A — Rapport au Conseil communal

Coût d'entretien par type de mobilier, top 5 des objets les plus coûteux, saisonnalité des interventions.

</div>

<div v-click class="p-3 border rounded">

### B — Plainte du quartier de la Gare

Délai moyen signalement → intervention par quartier, signalements ouverts > 30 jours, taux de résolution.

</div>

<div v-click class="p-3 border rounded">

### C — Remplacement des lampadaires

Fiche par lampadaire, score de priorité (pannes × âge × coût), sélection dans un budget de CHF 50'000.-.

</div>

<div v-click class="p-3 border rounded">

### D — Renouvellement des bancs

État du parc bois vs métal, bancs à remplacer sous 2 ans, estimation budgétaire et recommandation matériau.

</div>

</div>

---
layout: default
---

# Jalons du projet (formatifs, non notés)

Chaque jalon vous fait progresser — le feedback en classe ne compte pas dans la note.

| Jalon | Sem. | Livrable |
|---|---|---|
| **J0** Modélisation | 1-2 | MCD, MLD, qualité |
| **J1** Import | 3-4 | MPD, staging, nettoyage |
| **J2** Requêtes | 5-6 | Requêtes métier, index |
| **J3** Sécurité | 7-8 | Rôles, permissions |
| **J4** dbt + poster | 9-10 | Staging → marts, poster A3 |
| **J5** Présentation + poster | 28-29 mai | Poster A3 affiché + présentation |
| **Rendu final** | 31 mai | Scripts, jalons, adaptations |

---
layout: section
---

# Activité : premiers pas

---
layout: default
---

# Activité en classe (30 min)

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Étape 1 — Formation des groupes

<v-clicks>

1. **Former les groupes** (2-3 personnes)
2. **Tirer au sort** votre brief (A, B, C ou D)
3. **Ouvrir les 4 fichiers Excel** et les explorer

</v-clicks>

</div>

<div v-click>

### Étape 2 — Premières observations

En groupe, notez :

- Quels **problèmes de qualité** voyez-vous dans les données ?
- Quelles **colonnes** vous semblent utiles pour votre brief ?
- Quelles **relations** existent entre les fichiers ?
- Qu'est-ce qui **manque** pour répondre à votre brief ?

</div>

</div>

<div v-click class="accent-box mt-4">

Il n'y a pas de bonne réponse aujourd'hui. L'objectif est d'observer les données telles qu'elles sont, avant de les transformer.

</div>

---
layout: default
---

# Pour la semaine prochaine

<div class="grid grid-cols-2 gap-8">

<div>

### À faire

- **Créer un repo GitHub** de groupe
- **Lancer le `docker-compose`** fourni (PostgreSQL + PostGIS)
- **Explorer les 4 fichiers Excel** et noter les problèmes de qualité
- **Commencer le MCD** : quelles entités ? quelles relations ?

</div>

<div>

### À lire (optionnel mais recommandé)

- [Data Feminism, Introduction](https://data-feminism.mitpress.mit.edu/pub/frfa9szd)
- [PostgreSQL ACID](https://www.postgresql.org/docs/current/transaction-iso.html)

</div>

</div>

<div v-click class="accent-box mt-8">

**Prochain cours** : Module 02 — [Fondamentaux des bases de données](https://comem-infradon.onrender.com/02-fondamentaux/)

_CRUD, ACID, OLTP vs OLAP, vues et vues matérialisées_

</div>

---
layout: default
---

# Ressources du cours

### Livres

<div class="mosaic mosaic-3 mosaic-books mt-4" style="height: 200px;">
  <figure>
    <img src="/images/01-introduction/designing_data_intensive_applications.avif" />
    <figcaption>Kleppmann · Designing Data-Intensive Applications (2017)</figcaption>
  </figure>
  <figure>
    <img src="/images/01-introduction/data_mesh.jpeg" />
    <figcaption>Dehghani · Data Mesh (2022)</figcaption>
  </figure>
  <figure>
    <img src="/images/01-introduction/Data_Feminism.jpg" />
    <figcaption>D'Ignazio & Klein · Data Feminism (2020)</figcaption>
  </figure>
</div>

### En ligne

<div class="grid grid-cols-2 gap-4 mt-2" style="font-size: 0.8rem;">

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [dbt Documentation](https://docs.getdbt.com/)
- [FAIR Principles](https://www.go-fair.org/fair-principles/)

</div>

---
layout: end
---

# Questions ?
