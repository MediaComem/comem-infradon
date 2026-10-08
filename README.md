# Infrastructure de Données (InfraDon)

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

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
| [Git / GitHub](https://github.com/) | Versioning du projet |

Un fichier `docker-compose.yml` est fourni pour démarrer PostgreSQL + PostGIS.

---

## Cours

| # | Module | Contenu |
|---|--------|---------|
| 01 | [Introduction](https://comem-infradon.onrender.com/01-introduction/) | Composants d'une infrastructure, modèles de déploiement, projet fil rouge |
| 02 | [Import et nettoyage](https://comem-infradon.onrender.com/02-import-nettoyage/) | Qualité des données, staging, COPY, CASE, TRIM, COALESCE, TO_DATE, ROW_NUMBER, idempotence et ON CONFLICT |
| 03 | [Transactions et concurrence](https://comem-infradon.onrender.com/03-transactions-concurrence/) | ACID, anomalies de concurrence, niveaux d'isolation, MVCC, verrous, interblocages |
| 04 | [Sécurité, rôles et sauvegarde](https://comem-infradon.onrender.com/04-securite-roles-sauvegarde/) | GRANT/REVOKE, moindre privilège, suppression physique ou logique, pg_dump/pg_restore |
| 05 | [Structures et architectures](https://comem-infradon.onrender.com/05-structures-architectures/) | JSONB, index GIN et GiST, EXPLAIN ANALYZE, NoSQL, CAP et BASE, OLTP/OLAP, vues matérialisées, ETL/ELT, medallion, lakehouse, data mesh |
| 06 | [Éthique des données](https://comem-infradon.onrender.com/06-ethique-donnees/) | Impact environnemental, biais algorithmiques, souveraineté, nLPD/RGPD, gouvernance |

Les notions de base (CRUD, vues simples, index B-tree, plan d'exécution) sont vues au cours [Modélisation de Données](https://github.com/romanoe/comem-modeldon) du semestre 1.

---

## Évaluation

| Composante | Poids |
|---|---|
| Projet : présentation + poster A3 | 50% |
| Examen final : semaine d'examen | 50% |

---

## Projet fil rouge : Service technique communal d'Yverdon-les-Bains

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
| **J0** : Exploration et modélisation | 1-2 | MCD et MLD. Identifier les entités, relations et cardinalités. Documenter les problèmes de qualité observés dans les Excel | 01-02 |
| **J1** : Import et nettoyage | 3-4 | MPD (CREATE TABLE). Import des données brutes dans des tables staging. Nettoyage SQL : TRIM, COALESCE, regexp_replace, dédoublonnage. Migration staging vers tables finales | 02-03 |
| **J2** : Requêtes et optimisation | 5-6 | Premières requêtes métier pour le brief. EXPLAIN ANALYZE, index pertinents. Premières vues SQL | 03, 05 |
| **J3** : Sécurité et ouverture | 7-8 | Rôles et permissions (lecture seule pour citoyen-ne, écriture pour technicien-ne). Réflexion sur les structures alternatives adaptées au cas d'usage | 04 |
| **J4** : Vues métier + poster | 9-10 | Finalisation des requêtes et vues SQL pour le brief. Réflexion sur les structures de données. Préparation du poster A3 | 05-06 |
| **J5** : Présentation + poster | 28-29 mai | Poster A3 affiché en classe + présentation et discussion | 06 |
| **Rendu final** | 31 mai | Scripts, jalons, adaptations selon retour des présentations | 06 |

---

## Structure du projet

```
comem-infradon-1/
├── course.config.json            # Configuration du cours : titre, decks, liens TP
├── cours/                        # Slides Slidev (01-06), thème slidev-theme-pixel
│   ├── 01-introduction.md
│   ├── 02-import-nettoyage.md
│   ├── 03-transactions-concurrence.md
│   ├── 04-securite-roles-sauvegarde.md
│   ├── 05-structures-architectures.md
│   ├── 06-ethique-donnees.md
│   ├── components/               # Composants Vue.js propres au cours (vide)
│   ├── setup/                    # Thème Mermaid
│   └── public/                   # Images par cours (images/NN/), page d'accueil générée
├── projet/                       # Ressources du projet fil rouge
│   ├── briefs/                   # Briefs par groupe (A, B, C, D)
│   ├── data/                     # Fichiers Excel source (non versionnés)
│   └── aide-nettoyage.md         # Guide SQL de nettoyage
├── revisions/                    # Préparation à l'examen final
│   ├── examen-type.md            # Examen type (festival)
│   └── README.md                 # Ce qu'il faut maîtriser
├── scripts/                      # Build incrémental, serveur de dev, page d'accueil
├── package.json                  # Scripts npm
├── render.yaml                   # Déploiement Render.com
└── README.md
```

### Commandes

```bash
npm run dev -- 01      # serveur de dev pour le deck 01 (ou npm run dev:01)
npm run build          # build incrémental des decks modifiés
npm run build:force    # rebuild complet
npm run index          # régénère la page d'accueil depuis course.config.json
```

---

## Ressources

### Livres

- **Designing Data-Intensive Applications** : Kleppmann (2017), O'Reilly Media
- **Data Feminism**, D'Ignazio & Klein (2020), MIT Press : [accès libre](https://data-feminism.mitpress.mit.edu/)
- **Atlas of AI**, Crawford (2021), Yale University Press
- **Data Mesh**, Dehghani (2022), O'Reilly Media

### En ligne

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html)
- [Enjeux et perspectives pour une IA éthique et durable](https://stm.cairn.info/revue-enjeux-numeriques-2025-1-page-8?lang=fr) : *Annales des Mines, Enjeux numériques* n°29, 2025

---

## Licence

Ce matériel est mis à disposition sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

Vous êtes libre de partager et adapter ce contenu, à condition de créditer l'autrice.
