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
layout: section
---

# Infrastructure de données

---
layout: image-right
image: /images/01/schema-infrastructure.jpg
backgroundSize: contain
references:
  - "Acceldata, <em>Data Infrastructure: Building Reliable Data Ecosystems</em> (2024)"
  - "Fortra, <em>What Is Data Infrastructure?</em> (2024)"
---

# Plomberie numérique

- Outils, processus et technologies
- Collecter, stocker, traiter, exposer les données
- **Invisible** quand tout marche
- **Critique** quand ça casse
- Sans elle : des données inutilisables

---
layout: grid
cols: 3
align: stretch
content: center
references: "Fortra, <em>What Is Data Infrastructure? A Simple Overview</em> (2024)"
---

# Composants d'une infrastructure

<Card title="Stockage">
<template #icon><pixelarticons-database /></template>
Bases de données, data lakes, entrepôts, stockage objet.
</Card>
<Card title="Traitement">
<template #icon><pixelarticons-repeat /></template>
Pipelines ETL et ELT, moteurs de calcul, orchestration.
</Card>
<Card title="Accès">
<template #icon><pixelarticons-external-link /></template>
API, interfaces SQL, outils BI, tableaux de bord.
</Card>
<Card title="Sécurité">
<template #icon><pixelarticons-lock /></template>
Chiffrement, contrôle d'accès, audit, conformité nLPD et RGPD.
</Card>
<Card title="Gouvernance">
<template #icon><pixelarticons-book-open /></template>
Catalogue de données, traçabilité, règles de qualité.
</Card>
<Card title="Monitoring">
<template #icon><pixelarticons-chart /></template>
Observabilité, alertes, mesure continue de la qualité.
</Card>

---
layout: default
class: compact
---

# Flux de données

Une infrastructure se lit par ses **flux** : d'où vient la donnée, qui l'écrit, qui la lit, à quel rythme.

| Flux | Source | Rythme | Consommateur |
|---|---|---|---|
| Signalements | Population : application, téléphone, guichet | Continu | Technicien·ne·s |
| Interventions | Technicien·ne·s | Quotidien | Responsable, budget |
| Inventaire | Patrouilles, fournisseurs | Rare | Tout le service |
| Rapports | Base de données | Mensuel | Conseil communal |

<Card title="À retenir" color="#e92528">
<template #icon><pixelarticons-git-merge /></template>
Chaque flux a ses contraintes : volume, fraîcheur, données personnelles, tolérance à la panne.
</Card>

---
layout: grid
cols: 3
align: stretch
content: center
references: "Acceldata, <em>Building Reliable Data Ecosystems</em> (2024)"
---

# Modèles de déploiement

<Card title="Sur site">
<template #icon><pixelarticons-server /></template>
Serveurs dans vos locaux.<br>
<strong>+</strong> Contrôle total, souveraineté<br>
<strong>-</strong> Investissement, maintenance interne
</Card>
<Card title="Cloud">
<template #icon><pixelarticons-cloud /></template>
Serveurs loués à un fournisseur.<br>
<strong>+</strong> Flexibilité, mise à l'échelle<br>
<strong>-</strong> Dépendance, juridiction des données
</Card>
<Card title="Hybride">
<template #icon><pixelarticons-git-merge /></template>
Combinaison des deux.<br>
<strong>+</strong> Équilibre contrôle et flexibilité<br>
<strong>-</strong> Complexité, latence réseau
</Card>

Aucun modèle universel : le choix engage l'organisation sur le long terme.

---
layout: two-cols
---

::title::
# Panne du serveur

::left::

### Situation

> « Toutes nos données sont sur un serveur PostgreSQL, dans le bureau du responsable. Vendredi soir, une surtension a grillé le disque. »

### La question

Qu'est-ce qui n'allait pas ?

::right::

<v-click>

<Card title="Problèmes" color="#e92528">
<template #icon><pixelarticons-close /></template>
Aucune sauvegarde : trois ans de signalements perdus. Un seul serveur, aucune redondance.
</Card>

</v-click>

<v-click>

<Card title="À prévoir" color="#16a34a" footer="cours 04 · Sécurité, rôles et sauvegarde">
<template #icon><pixelarticons-check /></template>
Sauvegarde quotidienne vers un site distant. Plan de reprise documenté. Réplication sur un second serveur.
</Card>

</v-click>

---
layout: image-right
image: /images/01/web-app-architecture.png
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

# Environnement de travail

---
layout: two-cols
references: "Docker, <em>Docker overview</em>"
---

::title::
# Conteneurs

::left::

- **Image** : un environnement figé, `postgis/postgis:17-3.5`
- **Conteneur** : une image qui tourne
- **Volume** : des données qui survivent au conteneur
- Même version, même configuration pour tout le monde
- Supprimer et recréer en une commande

::right::

<Card title="Reproductible" color="#16a34a" tag="tip">
<template #icon><pixelarticons-repeat /></template>
« Chez moi, ça marche » disparaît : l'environnement est décrit dans un fichier.
</Card>

<Card color="#6b7280" tag="note" title="Production">
<template #icon><pixelarticons-server /></template>
Le même principe sert à déployer : le fichier décrit le serveur.
</Card>

---
layout: two-cols
references: "Docker, <em>Compose file reference</em>"
---

::title::
# docker-compose.yml

::left::

- `image` : PostgreSQL 17 avec PostGIS
- `environment` : utilisateur, mot de passe, base
- `ports` : accès depuis la machine hôte
- `pgdata` : la base, conservée entre deux démarrages
- `./data:/data` : les fichiers d'exercices

::right::

```yaml
services:
  postgres:
    image: postgis/postgis:17-3.5
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: yverdon
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./data:/data

volumes:
  pgdata:
```

---
layout: default
references: "Pro Git, <em>Git Basics</em>"
---

# Versionner une infrastructure

| Versionner | Ne pas versionner |
|---|---|
| `docker-compose.yml` | Mots de passe : fichier `.env` |
| Scripts SQL : schéma, import, nettoyage | Le volume de la base |
| `README.md` : comment tout relancer | Sauvegardes et dumps |
| `.gitignore` | Données personnelles |

<Card title="Infrastructure as code" color="#e92528" footer="cours 02 · import rejouable">
<template #icon><pixelarticons-git-branch /></template>
Si un script recrée la base, une erreur se corrige en relançant le script. Une manipulation à la main ne se rejoue pas.
</Card>

---
layout: section
---

# Programme

---
layout: default
class: compact
---

# Programme du semestre

| # | Cours | Technique | Regard critique |
|---|---|---|---|
| 01 | Introduction | Composants, Docker, Git | Flux de données, cadrage d'un besoin |
| 02 | Import et nettoyage | Staging, nettoyage SQL, rejets | Qualité et traçabilité |
| 03 | Transactions et concurrence | ACID, isolation, MVCC, verrous | Coût de la cohérence sous charge |
| 04 | Sécurité, rôles et sauvegarde | Moindre privilège, `pg_dump` | Panne, erreur humaine, fuite |
| 05 | Structures et architectures | JSONB, NoSQL, OLAP, lakehouse | Limites du relationnel, over-engineering |
| 06 | Éthique des données | Audit nLPD, indicateurs de qualité | Empreinte, souveraineté, biais |

---
layout: default
references:
  - "<a href='https://www.edoeb.admin.ch/fr/protection-des-donnees'>PFPDT, nLPD</a>"
  - "<a href='https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr'>Annales des Mines, <em>Enjeux numériques</em> n°29 (2025)</a>"
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

# Déroulement d'une séance

<Card title="Cours · 1 h">
<template #icon><pixelarticons-book-open /></template>
Les notions, un cas du Service technique, une question critique.
</Card>
<Card title="Travaux pratiques · 3 h">
<template #icon><pixelarticons-edit-box /></template>
Syntaxe de référence, puis exercices sur PostgreSQL, en classe.
</Card>
<Card title="Corrigés">
<template #icon><pixelarticons-check /></template>
Publiés une semaine après la séance. Exercices non notés.
</Card>

Chaque TP se termine par une question au format de l'examen.

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
Un dépôt personnel pour les scripts des exercices.
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
Tous les cours et les fichiers d'exercices.
</Card>
<Card title="Dépôt du cours">
<template #icon><logos-github-icon /></template>
<a href="https://github.com/MediaComem/comem-infradon">github.com/MediaComem/comem-infradon</a><br>
Objectifs, données du Service technique, révisions.
</Card>

---
layout: section
---

# Évaluation

---
layout: two-cols
---

::title::
# Examen final · 100 %

::left::

| Élément | Détail |
|---|---|
| Quand | Semaine d'examen |
| Format | Individuel, sur papier, 2 h |
| Documents | Une feuille A4 recto-verso manuscrite |
| Point de départ | Un schéma, un cas, un problème |
| Attendu | Proposer et justifier une solution |

::right::

<Card title="Préparation" color="#16a34a" tag="tip">
<template #icon><pixelarticons-edit-box /></template>
Les exercices des TP et leurs questions types. Un examen type est publié dans <code>revisions/</code>.
</Card>

<Card color="#6b7280" tag="note" title="Sans projet noté">
<template #icon><pixelarticons-note /></template>
Les exercices ne comptent pas dans la note : ils servent à s'entraîner.
</Card>

---
layout: section
---

# Cas fil rouge

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

<Card title="Le cas" color="#e92528">
<template #icon><pixelarticons-flag /></template>
Quatre fichiers Excel, tels quels. Chaque TP en fait un morceau d'<strong>infrastructure de données</strong> : import, concurrence, rôles, architecture, audit.
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

# Besoins du Service technique

Quatre demandes de la responsable, à cadrer pendant le TP.

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

### Déroulé

1. Environnement Docker et Git : 75 min
2. Exploration des fichiers Excel : 45 min
3. Flux et cadrage d'un besoin : 45 min
4. Question type : 15 min

<Card color="#6b7280" tag="note" title="Non noté">
<template #icon><pixelarticons-book-open /></template>
Les exercices préparent l'examen final.
</Card>

::right::

### Départ

1. Installer [Docker Desktop](https://www.docker.com/products/docker-desktop/) et [Git](https://git-scm.com/downloads)
2. Créer un dossier `infradon`, avec un sous-dossier `data`
3. Y télécharger [docker-compose.yml](https://comem-infradon.onrender.com/exercices/docker-compose.yml)
4. Télécharger les [fichiers Excel](https://github.com/MediaComem/comem-infradon/tree/main/projet/data)

---
layout: two-cols
references: "Docker, <em>docker compose CLI reference</em>"
---

::title::
# Syntaxe : docker compose

::left::

- `up -d` : démarrer en arrière-plan
- `ps` : état des conteneurs
- `logs` : messages du serveur
- `down` : arrêter, la base est conservée
- `down -v` : arrêter et **effacer** la base

::right::

```bash
docker compose up -d
docker compose ps
docker compose logs postgres

docker compose exec postgres \
  psql -U postgres -d yverdon

docker compose down
docker compose down -v   # efface pgdata
```

Docker Desktop : conteneur, onglet **Exec**, puis `psql -U postgres -d yverdon`.

---
layout: two-cols
references: "Pro Git, <em>Recording Changes to the Repository</em>"
---

::title::
# Syntaxe : git

::left::

- `init` : créer le dépôt
- `status` : fichiers modifiés
- `add` : préparer un fichier
- `commit` : enregistrer une version
- `.gitignore` : fichiers jamais versionnés

::right::

```bash
git init
git status
git add docker-compose.yml README.md
git commit -m "Environnement PostgreSQL"
git log --oneline
```

```text
# .gitignore
.env
data/*.dump
data/*.csv
```

---
layout: two-cols-bottom
---

::title::
# Exercice 1 : environnement

::left::

### Étapes

1. Démarrer la base avec `docker compose up -d`
2. Ouvrir `psql` dans l'onglet **Exec**
3. Vérifier les versions de PostgreSQL et de PostGIS
4. Créer une table, arrêter, redémarrer : est-elle encore là ?

::right::

```sql
SELECT version();
SELECT postgis_version();

CREATE TABLE test (id INTEGER);
\dt
```

```bash
ls /data
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Que devient la table après <code>docker compose down</code> ? Et après <code>docker compose down -v</code> ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 2 : versionner

::left::

### Étapes

1. Initialiser un dépôt Git dans `infradon`
2. Écrire `.gitignore` et un `README.md`
3. Écrire `01-test.sql` : la table de l'exercice 1
4. Commiter, puis publier le dépôt sur GitHub

::right::

```markdown
# InfraDon

## Démarrer
docker compose up -d

## Recréer la base
\i /data/01-test.sql
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Pourquoi versionner le script et pas le volume <code>pgdata</code>, ni un dump de la base ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 3 : explorer les fichiers

::left::

### Étapes

1. Ouvrir les quatre fichiers Excel
2. Relever trois problèmes de qualité par fichier
3. Repérer les colonnes qui relient les fichiers
4. Noter les données personnelles

::right::

| fichier | problèmes | liens |
|---|---|---|
| inventaire | | |
| signalements | | |
| interventions | | |
| fournisseurs | | |

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Quelle relation entre deux fichiers est impossible à établir telle quelle ? Pourquoi ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 4 : flux et besoin

::left::

### Étapes

1. Dessiner les flux du Service technique : sources, stockage, usages
2. Pour chaque flux : rythme, volume, qui écrit, qui lit
3. Choisir un besoin, de A à D
4. Le cadrer : objectif mesurable, données nécessaires, données manquantes

::right::

| besoin | |
|---|---|
| objectif | |
| données utiles | |
| données manquantes | |
| contraintes | |

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Les fichiers Excel suffisent-ils à répondre au besoin choisi ? Quel flux est le plus critique si la base tombe une journée ?
</Card>

---
layout: two-cols
---

::title::
# Exercice 5 : question type

::left::

### Situation

> « Chaque collègue installe PostgreSQL sur son poste. Les scripts SQL circulent par email. La base de référence est sur le portable du chef de projet. »

### Question

Relever trois risques. Pour chacun, quel outil ou quelle pratique y répond ?

::right::

| Risque | Réponse |
|---|---|
| | |
| | |
| | |

---
layout: two-cols
---

::title::
# Pour la prochaine séance

::left::

### À faire

- Terminer les exercices 1 à 4
- Garder la base démarrée et le dépôt à jour
- Relire les problèmes de qualité relevés

::right::

### Lectures

- [Data Feminism, introduction](https://data-feminism.mitpress.mit.edu/pub/frfa9szd)
- [Docker, Get started](https://docs.docker.com/get-started/)

<Card title="Prochain cours" color="#e92528" footer="cours 02 · Import et nettoyage">
<template #icon><pixelarticons-arrow-right /></template>
Qualité des données, staging, nettoyage SQL, rejets et traçabilité.
</Card>

---
layout: grid
cols: 3
---

# Ressources

<Figure
  class="w-1/2 mx-auto"
  src="/images/01/designing_data_intensive_applications.avif"
  caption="Kleppmann, <em>Designing Data-Intensive Applications</em> (2017)"
  alt="Couverture de Designing Data-Intensive Applications"
/>
<Figure
  class="w-1/2 mx-auto"
  src="/images/01/data_mesh.jpeg"
  caption="Dehghani, <em>Data Mesh</em> (2022)"
  alt="Couverture de Data Mesh"
/>
<Figure
  class="w-1/2 mx-auto"
  src="/images/01/Data_Feminism.jpg"
  caption="D'Ignazio et Klein, <em>Data Feminism</em> (2020)"
  href="https://data-feminism.mitpress.mit.edu/"
  alt="Couverture de Data Feminism"
/>

---
layout: default
---

# Ressources en ligne

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Pro Git](https://git-scm.com/book/fr/v2), en français
- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html)
- [FAIR Principles](https://www.go-fair.org/fair-principles/)

---
layout: section
---

# Questions
