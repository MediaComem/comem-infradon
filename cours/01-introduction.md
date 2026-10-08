---
theme: pixel
number: "01"
title: "Introduction"
subtitle: "Infrastructure de Données"
author: "Noemi Romano"
email: "noemi.romano@heig-vd.ch"
github: "https://github.com/MediaComem/comem-infradon"
breadcrumb: "Infrastructure de Données"
logos:
  - src: /images/logo-heig-vd.svg
    height: 60px
    link: https://www.heig-vd.ch/
    alt: "HEIG-VD"
    title: "HEIG-VD"
    class: "logo-heig"
  - src: /images/logo-hes-so.png
    height: 79px
    link: https://www.hes-so.ch/
    alt: "HES-SO"
    title: "HES-SO"
    class: "logo-hesso"

download: true
mdc: true
layout: cover
---

---
layout: grid
cols: 3
---

# Ce cours dans la formation

A travers le cycle de vie de la donnée :

<Card title="Modélisation" color="#6b7280" footer="ModelDon · semestre 1">
<template #icon><pixelarticons-tree /></template>
Structurer et formaliser les données d'un domaine métier
</Card>
<Card title="Infrastructure" color="#e92528" footer="InfraDon · semestre 2">
<template #icon><pixelarticons-server /></template>
Stocker, gérer et exposer des données fiables et accessibles à grande échelle. <strong>Ce cours</strong>
</Card>
<Card title="Visualisation" color="#6b7280" footer="VisualDon · semestre 5">
<template #icon><pixelarticons-chart-bar /></template>
Représenter les données pour en tirer du sens, raconter une histoire et appuyer les décisions
</Card>

---
layout: section
---

# Point de départ

---
layout: two-cols
---

::title::
# Acquis de ModelDon

::left::

- Besoin métier, puis données à stocker
- Modèle conceptuel, logique, physique
- `CREATE TABLE` et contraintes
- Requêtes, jointures, agrégations, vues
- Index et données JSON

::right::

<v-click>

<Card title="La question" color="#e92528">
<template #icon><pixelarticons-users /></template>
Les tables existent. Que se passe-t-il quand <strong>mille personnes</strong> y accèdent en même temps ?
</Card>

</v-click>

---
layout: grid
cols: 3fr 1fr 3fr 1fr 3fr
align: stretch
content: center
clicks: 2
---

# Modélisation, infrastructure, production

<Card title="Modélisation" :at="0" footer="ModelDon">
<template #icon><pixelarticons-tree /></template>
Quoi stocker
</Card>
<pixelarticons-arrow-right v-click="1" class="text-3xl self-center" />
<Card title="Infrastructure" :at="1" footer="Ce cours">
<template #icon><pixelarticons-server /></template>
Comment le stocker, le protéger, le faire évoluer
</Card>
<pixelarticons-arrow-right v-click="2" class="text-3xl self-center" />
<Card title="Production" :at="2">
<template #icon><pixelarticons-users /></template>
Systèmes réels, avec de vraies personnes utilisatrices
</Card>

---
layout: image-right
image: /images/01-introduction/web-app-architecture.png
backgroundSize: contain
caption: "Zealous Systems, <a href='https://www.zealousys.com/blog/web-application-architecture/'><em>What is Web Application Architecture</em></a>"
---

# Base de données comme composant

- Essentielle, mais pas suffisante
- À côté : caches, files d'attente, stockage objet
- Un outil par usage
- Ce cours : la **couche données**

---
layout: section
---

# Programme

---

# Compétences par cours

| # | Cours | Compétences |
|---|---|---|
| 01 | Introduction | Situer la base de données dans une infrastructure |
| 02 | Import et nettoyage | Importer des données brutes, les nettoyer en SQL |
| 03 | Transactions et concurrence | Garantir la cohérence face aux accès simultanés |
| 04 | Sécurité, rôles et sauvegarde | Protéger l'accès, sauvegarder et restaurer |
| 05 | Structures et architectures | Choisir une structure, concevoir un flux de données |
| 06 | Éthique des données | Évaluer les impacts environnementaux et sociaux |

---
layout: default
---

# Choix techniques et valeurs

| Décision | Question |
|---|---|
| **Cloud ou sur site** | Juridiction ? Souveraineté des données ? |
| **Propriétaire ou open source** | Dépendance à un fournisseur ? |
| **Dimensionnement** | Coût énergétique ou coût humain ? |
| **Rétention** | Que garder, et combien de temps ? |
| **Redondance et sauvegarde** | Quel coût pour une perte ? |
| **Structure** | Relationnel, NoSQL, graphe : pour quel usage ? |

<v-click>

<Card title="Aucun choix neutre" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Une infrastructure bien conçue documente et assume ses compromis.
</Card>

</v-click>

<div class="ref"><a href="https://www.edoeb.admin.ch/fr/protection-des-donnees">nLPD</a> · <a href="https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr">Enjeux et perspectives pour une IA éthique et durable, <em>Annales des Mines</em> n°29 (2025)</a></div>

---
layout: section
---

# Organisation

---
layout: grid
cols: 3
align: stretch
content: center
---

# Outils

<Card title="PostgreSQL + PostGIS">
<template #icon><logos-postgresql /></template>
Le SGBD du cours, extension spatiale comprise.
</Card>
<Card title="Docker">
<template #icon><logos-docker-icon /></template>
Un <code>docker-compose.yml</code> fourni démarre la base.
</Card>
<Card title="Git et GitHub">
<template #icon><logos-github-icon /></template>
Un dépôt par groupe pour le projet.
</Card>

---
layout: grid
cols: 2
align: stretch
content: center
---

# Liens utiles

<Card title="Slides du cours">
<template #icon><pixelarticons-external-link /></template>
<a href="https://comem-infradon.onrender.com">comem-infradon.onrender.com</a><br>
Tous les cours du semestre, mis à jour au fil des séances.
</Card>
<Card title="Dépôt du cours">
<template #icon><logos-github-icon /></template>
<a href="https://github.com/MediaComem/comem-infradon">github.com/MediaComem/comem-infradon</a><br>
Objectifs, briefs et données du projet, jalons.
</Card>

---
layout: section
---

# Évaluation

---
layout: two-cols
---

::title::
# Répartition

::left::

<Card title="Projet · 50%">
<template #icon><pixelarticons-users /></template>
Groupes de 2-3 · Poster A3 affiché en classe · Présentation et questions · Rendu final des scripts
</Card>

::right::

<Card title="Examen final · 50%" color="#16a34a">
<template #icon><pixelarticons-edit-box /></template>
Semaine d'examen · Individuel · Sur ordinateur · 3h
</Card>

---
layout: default
---

# Examen final

Une mise en situation, comme sur le terrain.

| Élément | Détail |
|---|---|
| Point de départ | Un schéma, un cas, un problème |
| Attendu | Proposer et justifier une solution |
| Format | Individuel, sur ordinateur, 3h |
| Poids | 50% de la note finale |

---
layout: section
---

# Projet fil rouge

---
layout: two-cols
---

::title::
# Service technique d'Yverdon-les-Bains

::left::

- Mobilier urbain suivi dans Excel depuis 2018
- Bancs, lampadaires, fontaines, poubelles, bornes
- Signalements de la population
- Interventions de maintenance
- Liste de fournisseurs

::right::

<Card title="Mission" color="#e92528">
<template #icon><pixelarticons-flag /></template>
Quatre fichiers Excel, tels quels. En faire une <strong>infrastructure de données</strong> fonctionnelle, optimisée et utile.
</Card>
<Card color="#6b7280" tag="note" title="Données fictives">
<template #icon><pixelarticons-note /></template>
Noms, numéros et coordonnées générés pour le cours.
</Card>

---
layout: grid
cols: 2
align: stretch
---

# Données du Service technique

<Card title="inventaire_mobilier.xlsx">
<template #icon><pixelarticons-map-pin /></template>
~120 objets avec leur position GPS dans la commune.
</Card>
<Card title="signalements.xlsx">
<template #icon><pixelarticons-warning-box /></template>
~200 signalements : dates, texte libre, urgence, statut.
</Card>
<Card title="interventions.xlsx">
<template #icon><pixelarticons-tool-case /></template>
~150 interventions : technicien·ne·s, durée, coûts.
</Card>
<Card title="fournisseurs_contacts.xlsx">
<template #icon><pixelarticons-truck /></template>
~15 fournisseurs régionaux : contacts, spécialités.
</Card>

Données volontairement **imparfaites**, comme de vrais fichiers Excel faits à la main.

---
layout: grid
cols: 2
align: stretch
---

# Briefs

Mêmes données pour tous les groupes, un brief différent par groupe.

<Card title="A · Rapport budgétaire">
<template #icon><pixelarticons-money /></template>
Coût par type de mobilier, top 5 des objets coûteux, saisonnalité.
</Card>
<Card title="B · Délais de traitement">
<template #icon><pixelarticons-clock /></template>
Délai moyen par quartier, signalements ouverts depuis plus de 30 jours.
</Card>
<Card title="C · Remplacement des lampadaires">
<template #icon><pixelarticons-lightbulb /></template>
Score de priorité, sélection dans un budget de CHF 50'000.-.
</Card>
<Card title="D · Renouvellement des bancs">
<template #icon><pixelarticons-building-community /></template>
État du parc, bancs à remplacer sous 2 ans, estimation budgétaire.
</Card>

---
layout: default
class: compact
---

# Jalons du projet

Formatifs : le retour en classe ne compte pas dans la note.

| Jalon | Semaines | Livrable |
|---|---|---|
| **J0** Exploration et modélisation | 1-2 | MCD, MLD, problèmes de qualité |
| **J1** Import et nettoyage | 3-4 | MPD, staging, nettoyage SQL |
| **J2** Requêtes et optimisation | 5-6 | Requêtes métier, index, premières vues |
| **J3** Sécurité et ouverture | 7-8 | Rôles et permissions, structures alternatives |
| **J4** Vues métier et poster | 9-10 | Vues finales, poster A3 |
| **J5** Présentation | Fin du semestre | Poster affiché, présentation |
| **Rendu final** | Fin du semestre | Scripts, jalons, adaptations |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# Travail pratique · Semaine 1

::left::

### Étapes

1. Former les groupes de 2-3
2. Tirer au sort un brief : A, B, C ou D
3. Ouvrir et explorer les quatre fichiers Excel

<Card color="#6b7280" tag="note" title="Pas de bonne réponse">
<template #icon><pixelarticons-zoom-in /></template>
Observer les données telles qu'elles sont, avant de les transformer.
</Card>

::right::

### Observations

- Problèmes de qualité
- Colonnes utiles au brief
- Relations entre les fichiers
- Données manquantes pour le brief

---
layout: two-cols
---

::title::
# Pour la prochaine séance

::left::

### À faire

- Créer un dépôt GitHub de groupe
- Lancer le `docker-compose` fourni
- Noter les problèmes de qualité
- Esquisser le MCD : entités et relations

::right::

### Lectures

- [Data Feminism, introduction](https://data-feminism.mitpress.mit.edu/pub/frfa9szd)
- [PostgreSQL, isolation des transactions](https://www.postgresql.org/docs/current/transaction-iso.html)

<Card title="Prochain cours" color="#e92528" footer="cours 02 · Import et nettoyage">
<template #icon><pixelarticons-arrow-right /></template>
Staging, qualité des données, nettoyage SQL.
</Card>

---
layout: grid
cols: 3
---

# Ressources

<Figure
  class="w-1/2 mx-auto"
  src="/images/01-introduction/designing_data_intensive_applications.avif"
  caption="Kleppmann, <em>Designing Data-Intensive Applications</em> (2017)"
  alt="Couverture de Designing Data-Intensive Applications"
/>
<Figure
  class="w-1/2 mx-auto"
  src="/images/01-introduction/data_mesh.jpeg"
  caption="Dehghani, <em>Data Mesh</em> (2022)"
  alt="Couverture de Data Mesh"
/>
<Figure
  class="w-1/2 mx-auto"
  src="/images/01-introduction/Data_Feminism.jpg"
  caption="D'Ignazio et Klein, <em>Data Feminism</em> (2020)"
  href="https://data-feminism.mitpress.mit.edu/"
  alt="Couverture de Data Feminism"
/>

---
layout: default
---

# Ressources en ligne

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html)
- [FAIR Principles](https://www.go-fair.org/fair-principles/)

---
layout: section
---

# Questions
