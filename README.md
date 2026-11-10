# Infrastructure de Données (InfraDon)

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

Cours **Infrastructure de Données** de la filière Ingénierie des Médias, HEIG-VD.

Ce document est mis à jour au fur et à mesure du semestre avec les informations du cours, les fichiers d'exercices et les ressources.

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
| [Git / GitHub](https://github.com/) | Versionnement des scripts d'exercices |

Le fichier [`docker-compose.yml`](cours/public/exercices/docker-compose.yml) démarre PostgreSQL 17 + PostGIS et crée la base `yverdon`. Il est aussi [téléchargeable](https://comem-infradon.onrender.com/exercices/docker-compose.yml) depuis le site du cours.

---

## Cours

| # | Module | Contenu |
|---|--------|---------|
| 01 | [Introduction](https://comem-infradon.onrender.com/01-introduction/) | Composants d'une infrastructure, flux de données, modèles de déploiement, conteneurs, versionnement. TP : environnement Docker et Git, exploration des fichiers, cadrage d'un besoin |
| 02 | [Import et nettoyage](https://comem-infradon.onrender.com/02-import-nettoyage/) | Qualité des données, staging, COPY, propagation des erreurs, rejets, traçabilité et journal d'import, idempotence et ON CONFLICT. TP : profilage, nettoyage SQL, table de rejets, import rejouable |
| 03 | [Transactions et concurrence](https://comem-infradon.onrender.com/03-transactions-concurrence/) | ACID, anomalies de concurrence, niveaux d'isolation, MVCC, verrous, interblocages, coût de la cohérence. TP : anomalies à plusieurs sessions, mesures avec pgbench |
| 04 | [Sécurité, rôles et sauvegarde](https://comem-infradon.onrender.com/04-securite-roles-sauvegarde/) | GRANT/REVOKE, moindre privilège, audit des rôles, fuites de données, suppression physique ou logique, RPO/RTO, pg_dump/pg_restore, scénarios de panne. TP : audit et correction des rôles, suppression logique, sauvegarde, restauration après incident |
| 05 | [Structures et architectures](https://comem-infradon.onrender.com/05-structures-architectures/) | Limites du relationnel, NoSQL, CAP et BASE, OLTP/OLAP, ETL/ELT, medallion, lakehouse, data mesh, over-engineering. TP : JSONB, index GIN, EXPLAIN ANALYZE, vues matérialisées, choix d'architecture |
| 06 | [Éthique des données](https://comem-infradon.onrender.com/06-ethique-donnees/) | Gouvernance, qualité des données mesurée, nLPD/RGPD et audit de conformité, empreinte environnementale, souveraineté, biais. TP : inventaire et registre, pseudonymisation et rétention, indicateurs de qualité, biais de signalement |

Les notions de base (CRUD, vues simples, index B-tree, plan d'exécution) sont vues au cours [Modélisation de Données](https://github.com/romanoe/comem-modeldon) du semestre 1.

---

## Organisation

Chaque séance comprend 1 h de cours et 3 h de travaux pratiques en classe. Les exercices ne sont pas notés : ils se terminent par une question au format de l'examen. Les corrigés sont publiés une semaine après la séance.

---

## Évaluation

| Composante | Poids |
|---|---|
| Examen final : semaine d'examen | 100% |

---

## Cas fil rouge : Service technique communal d'Yverdon-les-Bains

La personne en charge du Service technique de la Commune d'Yverdon-les-Bains gère depuis 2018 le mobilier urbain (bancs, lampadaires, fontaines, poubelles, bornes de recharge) dans des fichiers Excel. Elle note les signalements de la population, enregistre les interventions de maintenance et tient une liste de fournisseurs. Les travaux pratiques en font, séance après séance, une infrastructure de données.

> **Note** : toutes les données sont **fictives**. Les noms, numéros de téléphone, coordonnées et autres informations personnelles ont été générés pour les besoins du cours et ne correspondent à aucune personne réelle.

### Données

| Fichier | Description |
|---|---|
| `projet/data/inventaire_mobilier.xlsx` | ~120 objets (bancs, lampadaires, fontaines, poubelles, bornes EV) avec positions GPS |
| `projet/data/signalements.xlsx` | ~200 signalements de la population et de patrouilles |
| `projet/data/interventions.xlsx` | ~150 interventions de maintenance (dates, technicien-ne-s, durée, coûts) |
| `projet/data/fournisseurs_contacts.xlsx` | ~15 fournisseurs régionaux avec contacts et spécialités |

Les données sont volontairement imparfaites : casse variable, formats de date incohérents, références par texte libre, champs vides. Comme de vrais fichiers Excel faits à la main.

### Besoins

Quatre demandes du Service technique, cadrées pendant le TP du cours 01 :

| Besoin | Thème | Détail |
|---|---|---|
| [A](projet/briefs/brief_a_budget.md) | Rapport budgétaire | Coût par type de mobilier, top 5 objets coûteux, saisonnalité |
| [B](projet/briefs/brief_b_delais.md) | Délais de traitement | Délai moyen par quartier, signalements ouverts > 30 jours, taux de résolution |
| [C](projet/briefs/brief_c_lampadaires.md) | Remplacement lampadaires | Fiche par lampadaire, score de priorité, sélection dans un budget de CHF 50'000.- |
| [D](projet/briefs/brief_d_bancs.md) | Renouvellement des bancs | État du parc, bancs à remplacer sous 2 ans, estimation budgétaire |

### Fichiers d'exercices

Les fichiers des TP sont dans [`cours/public/exercices/`](cours/public/exercices/) et en ligne sous `https://comem-infradon.onrender.com/exercices/`. Les copier dans le dossier `data`, monté sous `/data` dans le conteneur.

| Cours | Fichiers |
|---|---|
| 01 | `docker-compose.yml` |
| 02 | `02-import.sql`, `02-interventions.csv` |
| 03 | `03-banque.sql`, `03-virement.sql`, `03-virement-ordonne.sql` |
| 04 | `04-service-technique.sql`, `04-incident.sql` |
| 05 | `05-mobilier.sql` |
| 06 | `06-service-technique.sql` |

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
│   └── public/                   # Images par cours (images/NN/), fichiers d'exercices (exercices/), page d'accueil générée
├── projet/                       # Ressources du cas fil rouge
│   ├── briefs/                   # Besoins du Service technique (A, B, C, D)
│   ├── data/                     # Fichiers Excel et CSV source
│   ├── generate_data.py          # Génération des données fictives
│   └── aide-nettoyage.md         # Guide SQL de nettoyage
├── revisions/                    # Préparation à l'examen final
│   ├── examen-type.md            # Examen type (festival)
│   └── README.md                 # Ce qu'il faut maîtriser
├── scripts/                      # Build incrémental, serveur de dev, page d'accueil, export PDF
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
