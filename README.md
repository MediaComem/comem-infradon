# Infrastructure de Données 1 (InfraDon1)

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

Cours **Infrastructure de Données** de la filière Ingénierie des Médias, HEIG-VD.

Ce document est mis à jour au fur et à mesure du semestre avec les informations du cours, les jalons du projet et les ressources.

---

## Objectifs

- Comprendre les enjeux liés à l'infrastructure de données : concurrence, performance, sécurité, durabilité
- Savoir importer, nettoyer et transformer des données brutes en une base exploitable.
- Comparer les différentes structures de données et choisir la plus adaptée à un besoin donné
- Concevoir et mettre en oeuvre des pipelines de transformation de données (ETL/ELT)
- Sécuriser, optimiser et automatiser une infrastructure de données
- Porter un regard critique sur les dimensions éthiques et environnementales des systèmes de données

---

## Outils

| Outil | Usage |
|---|---|
| [PostgreSQL](https://www.postgresql.org/) + [PostGIS](https://postgis.net/) | SGBD principal |
| [Docker](https://www.docker.com/) | Conteneurisation de l'environnement |
| [dbt](https://www.getdbt.com/) | Transformation et pipelines de données |
| [Git / GitHub](https://github.com/) | Versioning du projet |

Un fichier `docker-compose.yml` est fourni pour démarrer PostgreSQL + PostGIS.

---

## Cours

| # | Module | Contenu |
|---|--------|---------|
| 01 | [Introduction](cours/01-introduction.md) | Présentation du cours, outils, projet fil rouge |
| 02 | [Fondamentaux des bases de données](cours/02-fondamentaux.md) | CRUD, ACID, OLAP vs OLTP, vues, vues matérialisées |
| 03 | [Import et nettoyage des données](cours/03-import-nettoyage.md) | Import Excel vers PostgreSQL, staging, CAST, TRIM, COALESCE, regexp_replace, dédoublonnage |
| 04 | [Transactions et concurrence](cours/04-transactions-concurrence.md) | Niveaux d'isolation, verrous, deadlocks |
| 05 | [Optimisation et indexation](cours/05-optimisation-indexation.md) | EXPLAIN ANALYZE, types d'index (B-tree, GIN, GiST), vues matérialisées |
| 06 | [Sécurité, rôles et sauvegarde](cours/06-securite-roles-sauvegarde.md) | GRANT/REVOKE, Row-Level Security, pg_dump/pg_restore, stratégies de backup |
| 07 | [Structures de données](cours/07-structures-donnees.md) | Relationnel vs NoSQL (document, key-value, colonnes, graph), stockage médias, cas concrets (Instagram, TikTok, Spotify) |
| 08 | [Flux de données et data engineering](cours/08-flux-donnees-data-engineering.md) | ETL vs ELT, triggers, CDC, dbt (models, sources, tests, seeds), workflows de transformation |
| 09 | [Architectures modernes](cours/09-architectures-modernes.md) | Data mesh, architecture medallion, lakehouse, RAG, systèmes cloud |
| 10 | [Éthique et durabilité des données](cours/10-ethique-durabilite.md) | Impact environnemental, biais, gouvernance, RGPD/nLPD, data feminism |

---

## Évaluation

| Composante | Poids |
|---|---|
| Projet — présentation + poster A3 | 50% |
| Examen final — semaine d'examen | 50% |

---

## Projet fil rouge — Service technique communal d'Yverdon-les-Bains

### Contexte

La personne en charge du Service technique de la Commune d'Yverdon-les-Bains gère depuis 2018 le mobilier urbain (bancs, lampadaires, fontaines, poubelles, bornes de recharge) dans des fichiers Excel. Elle note les signalements de la population, enregistre les interventions de maintenance et tient une liste de fournisseurs.

Vous recevez les **4 fichiers Excel** tels quels. Votre mission : en faire une **infrastructure de données** fonctionnelle, optimisée et utile.

> **Note** : toutes les données du projet sont **fictives**. Les noms, numéros de téléphone, coordonnées et autres informations personnelles ont été générés pour les besoins du cours et ne correspondent à aucune personne réelle.

### Données

| Fichier | Description |
|---|---|
| `projet/data/inventaire_mobilier.xlsx` | ~120 objets (bancs, lampadaires, fontaines, poubelles, bornes EV) avec positions GPS |
| `projet/data/signalements.xlsx` | ~200 signalements de la population et de patrouilles |
| `projet/data/interventions.xlsx` | ~150 interventions de maintenance (dates, technicien-ne-s, durée, coûts) |
| `projet/data/fournisseurs_contacts.xlsx` | ~15 fournisseurs régionaux avec contacts et spécialités |

Les données sont volontairement imparfaites : casse variable, formats de date incohérents, références par texte libre, champs vides. Comme de vrais fichiers Excel faits à la main.

### Briefs

Chaque groupe (2-3 personnes) reçoit les mêmes données mais un brief différent :

| Brief | Thème | Détail |
|---|---|---|
| [A](projet/briefs/brief_a_budget.md) | Rapport budgétaire | Coût par type de mobilier, top 5 objets coûteux, saisonnalité |
| [B](projet/briefs/brief_b_delais.md) | Délais de traitement | Délai moyen par quartier, signalements ouverts > 30 jours, taux de résolution |
| [C](projet/briefs/brief_c_lampadaires.md) | Remplacement lampadaires | Fiche par lampadaire, score de priorité, sélection dans un budget de CHF 50'000.- |
| [D](projet/briefs/brief_d_bancs.md) | Renouvellement des bancs | État du parc, bancs à remplacer sous 2 ans, estimation budgétaire |

### Jalons du projet (formatifs)

| Jalon | Semaines | Livrable | Cours |
|---|---|---|---|
| **J0** — Exploration et modélisation | 1-2 | MCD et MLD. Identifier les entités, relations et cardinalités. Documenter les problèmes de qualité observés dans les Excel | 01-02 |
| **J1** — Import et nettoyage | 3-4 | MPD (CREATE TABLE). Import des données brutes dans des tables staging. Nettoyage SQL : TRIM, COALESCE, regexp_replace, dédoublonnage. Migration staging vers tables finales | 03-04 |
| **J2** — Requêtes et optimisation | 5-6 | Premières requêtes métier pour le brief. EXPLAIN ANALYZE, index pertinents. Premières vues SQL | 05-06 |
| **J3** — Sécurité et ouverture | 7-8 | Rôles et permissions (lecture seule pour citoyen-ne, écriture pour technicien-ne). Réflexion sur les structures alternatives adaptées au cas d'usage | 07-08 |
| **J4** — Pipeline dbt + poster | 9-10 | Refactoring du nettoyage avec dbt (staging vers marts). Tests dbt. Documentation. Préparation du poster A3 | 08-09 |
| **J5** — Présentation + poster | 28-29 mai | Poster A3 affiché en classe + présentation et discussion | 09-10 |
| **Rendu final** | 31 mai | Scripts, jalons, adaptations selon retour des présentations | — |

---

## Ressources

### Livres

- **Designing Data-Intensive Applications** — Kleppmann (2017), O'Reilly Media
- **Data Feminism** — D'Ignazio & Klein (2020), MIT Press — [accès libre](https://data-feminism.mitpress.mit.edu/)
- **Atlas of AI** — Crawford (2021), Yale University Press
- **Data Mesh** — Dehghani (2022), O'Reilly Media

### En ligne

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [dbt Documentation](https://docs.getdbt.com/)
- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html)
- [Enjeux et perspectives pour une IA éthique et durable](https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr) — *Annales des Mines — Enjeux numériques* n°29, 2025

---

## Licence

Ce matériel est mis à disposition sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

Vous êtes libre de partager et adapter ce contenu, à condition de créditer l'autrice.
