---
theme: default
download: true
title: "02 - Fondamentaux des infrastucture de données"
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
    <h1 class="cover-title">02 - Fondamentaux </h1>
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

# Qu'est-ce que l'infrastructure de données ?

<p class="section-subtitle">Composants, modèles de déploiement, et premiers points de défaillance</p>

---
layout: default
---

# La plomberie numérique

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

- **Outils, processus et technologies** pour collecter, stocker, traiter et exposer les données
- **Invisible quand ça marche**, critique quand ça casse
- **Fondation** de toute organisation pilotée par la donnée
- Sans infrastructure fiable → données inutilisables

</v-clicks>

</div>

<img src="/images/02-fondamentaux/schema-infrastructure.jpg" class="rounded" style="max-height: 100%; object-fit: contain;" />

</div>

<div class="footer"><a href="https://www.acceldata.io/blog/data-infrastructure">Acceldata · Data Infrastructure: Building Reliable Data Ecosystems (2024)</a> · <a href="https://www.fortra.com/blog/what-data-infrastructure-simple-overview">Fortra · What Is Data Infrastructure? (2024)</a></div>

---
layout: default
---

# Les composants d'une infrastructure

<div class="grid grid-cols-3 gap-4 mt-6 text-sm">

<div v-click class="p-3 border rounded">

<carbon-data-base /> **Stockage**

Bases de données, data lakes, data warehouses, stockage objet

</div>

<div v-click class="p-3 border rounded">

<carbon-flow /> **Traitement**

ETL/ELT pipelines, moteurs de calcul (Spark, dbt), orchestration

</div>

<div v-click class="p-3 border rounded">

<carbon-dashboard /> **Accès**

APIs, interfaces SQL, outils BI, tableaux de bord

</div>

<div v-click class="p-3 border rounded">

<carbon-locked /> **Sécurité**

Chiffrement, contrôle d'accès, audit, conformité (LPD, RGPD)

</div>

<div v-click class="p-3 border rounded">

<carbon-catalog /> **Gouvernance**

Catalogue de données, traçabilité, règles de qualité

</div>

<div v-click class="p-3 border rounded">

<carbon-activity /> **Monitoring**

Observabilité, alertes, mesure de la qualité en continu

</div>

</div>

<div class="footer"><a href="https://www.fortra.com/blog/what-data-infrastructure-simple-overview">Fortra · What Is Data Infrastructure? A Simple Overview (2024)</a></div>

---
layout: default
---

# Trois modèles de déploiement

<div class="grid grid-cols-3 gap-6 mt-6">

<div v-click class="p-4 border rounded">

<carbon-data-center /> **On-premise**

Serveurs dans vos locaux

**+** Contrôle total, souveraineté des données

**–** Coût d'investissement élevé, maintenance interne

</div>

<div v-click class="p-4 border rounded">

<carbon-cloud /> **Cloud**

AWS, GCP, Azure, Scaleway…

**+** Flexibilité, scalabilité, pas de CapEx

**–** Dépendance fournisseur, juridiction des données

</div>

<div v-click class="p-4 border rounded">

<carbon-hybrid-networking /> **Hybride**

Combinaison des deux

**+** Équilibre contrôle / flexibilité

**–** Complexité de gestion, latence réseau

</div>

</div>

<div v-click class="accent-box mt-6">

Il n'y a pas de modèle universel. Le choix dépend du contexte réglementaire, du budget et de la criticité des données - et engage l'organisation sur le long terme.

</div>

<div class="footer"><a href="https://www.acceldata.io/blog/data-infrastructure">Acceldata · Building Reliable Data Ecosystems (2024)</a></div>

---
layout: default
---

# Quel est le problème ?

<div class="text-sm text-gray-500 italic mb-2">
<strong>Scénario</strong> : Le service technique d'Yverdon stocke ses données dans un unique serveur PostgreSQL on-premise, installé dans le bureau du responsable. Ce vendredi soir, une surtension électrique grille le disque dur.

</div>


<div class="mt-4 text-sm text-gray-500 italic">Discussion (1 min) : qu'est-ce qui ne va pas ici ?</div>

<div v-click class="grid grid-cols-2 gap-2 mt-2" style="font-size: 0.72rem; line-height: 1.3;">

<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Problèmes</strong><ul class="mt-1 ml-3 list-disc"><li>Pas de backup → 3 ans de signalements perdus définitivement</li><li>Single point of failure → aucune haute disponibilité</li><li>On-premise sans redondance → pas de résilience face à un sinistre</li></ul></div>

<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Ce qu'on aurait dû prévoir</strong><ul class="mt-1 ml-3 list-disc"><li>Backup automatique quotidien vers un site distant (ou cloud)</li><li>Plan de disaster recovery documenté</li><li>Réplication sur un second nœud en standby</li></ul><div class="mt-1">→ Stratégies de sauvegarde et réplication : <a class="module-link" href="https://comem-infradon.onrender.com/06-securite-roles-sauvegarde/">module 06</a></div></div>

</div>

---
layout: section
---

# CRUD - l'interface minimale

<p class="section-subtitle">Les 4 opérations de base, l'idempotence et la suppression sans retour</p>

---
layout: default
---

# Les 4 opérations fondamentales

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

Toute interface de données expose au minimum :

- **C**REATE : ajouter
- **R**EAD : lire, interroger
- **U**PDATE : modifier
- **D**ELETE : supprimer

</v-clicks>

<div v-click class="accent-box mt-6">

CRUD est une **abstraction**, pas une syntaxe. Elle s'applique à tout système de stockage, quel que soit le modèle ou la technologie.

</div>

</div>

<div v-click>

| Système | CREATE | READ | UPDATE | DELETE |
|---------|--------|------|--------|--------|
| SQL | `INSERT` | `SELECT` | `UPDATE` | `DELETE` |
| REST API | `POST` | `GET` | `PUT / PATCH` | `DELETE` |
| MongoDB | `insertOne` | `find` | `updateOne` | `deleteOne` |
| Redis | `SET` | `GET` | `SET` | `DEL` |
| S3 | `PUT` | `GET` | `PUT` | `DELETE` |

</div>

</div>

---
layout: default
---

# Idempotence

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

**Idempotente** : N exécutions = même résultat qu'une seule

- **READ** : toujours idempotent
- **DELETE** : idempotent : supprimer ce qui n'existe plus = no-op
- **PUT / UPSERT** : idempotent : résultat final toujours identique
- **POST / INSERT** : **non idempotent** par défaut : deux appels = deux enregistrements

</v-clicks>

</div>

<div v-click>

### Pourquoi ça compte en infrastructure

Systèmes distribués : pannes + **réessais** automatiques

```
Réseau coupe après l'écriture,
avant l'acquittement

→ le client réessaie automatiquement
→ sans idempotence : double insertion
→ avec idempotence : même état final
```

<div class="accent-box mt-4">

Idempotence = règle fondamentale d'infrastructure distribuée

</div>

</div>

</div>

---
layout: default
---

# Quel est le problème ?

<div class="text-sm text-gray-500 italic mb-2">
<strong>Scénario</strong> : Un agent de terrain signale une fontaine cassée via une app mobile. La connexion est mauvaise. L'app réessaie automatiquement après un timeout. Résultat dans la base :

</div>



<div v-click class="mt-4 text-sm">

| id | objet_id | date | description | statut |
|----|----------|------|-------------|--------|
| 201 | FONT-012 | 2024-03-15 | fontaine cassée | ouvert |
| 202 | FONT-012 | 2024-03-15 | fontaine cassée | ouvert |
| 203 | FONT-012 | 2024-03-15 | fontaine cassée | ouvert |

</div>



<div v-click class="grid grid-cols-2 gap-2 mt-2" style="font-size: 0.72rem; line-height: 1.3;">

<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Problème</strong><br/>L'opération <code>INSERT signalement</code> n'est pas idempotente. Chaque réessai crée un nouveau doublon.</div>

<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Solution</strong><br/>Générer un identifiant unique côté client (ex : hash objet + date + auteur). Utiliser un <code>INSERT ... ON CONFLICT DO NOTHING</code> côté base.</div>

</div>

---
layout: default
---

# Soft delete vs Hard delete

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

- **Hard delete** : effacement définitif
- **Soft delete** : marquée supprimée (`deleted_at`, `is_active`), mais conservée
- **Décision d'infrastructure** : engage auditabilité, conformité légale, performances

</v-clicks>

</div>

<div v-click>

| | Hard delete | Soft delete |
|---|---|---|
| Auditabilité | ✗ | ✓ |
| Réversibilité | ✗ | ✓ |
| RGPD, LPD (droit à l'effacement) | ✓ direct | Complexe |
| Intégrité référentielle | Risque cascade | Préservée |
| Accumulation de données | Non | Oui |
| Requêtes | Simples | Filtrer `deleted_at IS NULL` |



</div>


</div>
<div v-click class="accent-box">

Le RGPD/LPD crée un paradoxe : le droit à l'oubli oblige parfois à supprimer ce qu'on aurait voulu conserver pour l'audit.

→ Rôles, permissions et conformité : <a class="module-link" href="https://comem-infradon.onrender.com/06-securite-roles-sauvegarde/">module 06</a>

</div>

---
layout: section
---

# Qualité et intégrité des données

<p class="section-subtitle">Les 6 dimensions, le schéma comme contrat, et le coût d'une donnée corrompue</p>

---
layout: default
---

# Le coût d'une donnée corrompue

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

- **Coûts cachés** qui se propagent à travers toute l'organisation
- Se **propage** à chaque rapport, pipeline, décision
- Corriger à l'entrée coûte 1 → corriger en production coûte 100

</v-clicks>

<div v-click class="accent-box mt-4">

**Mieux vaut refuser une donnée à l'entrée que la corriger en aval.**

</div>

</div>

<div v-click>

### Dans notre projet

Les fichiers Excel du service technique contiennent :

- Dates dans des formats différents
- Valeurs manquantes dans des colonnes critiques
- Noms de techniciens saisis à la main (fautes, variantes)
- Doublons partiels entre fichiers

→ La qualité des données est un problème d'**infrastructure** autant que de processus humain

</div>

</div>

<div class="footer"><a href="https://www.ibm.com/think/insights/cost-of-poor-data-quality">Krantz & Jonker · The True Cost of Poor Data Quality (IBM Think, 2026)</a></div>

---
layout: default
---

# Les 6 dimensions de la qualité des données

<div class="grid grid-cols-3 gap-4 mt-4 text-sm">

<div v-click class="p-3 border rounded">

### Précision
La donnée reflète fidèlement la réalité

*Ex : coordonnées GPS correctes*

</div>

<div v-click class="p-3 border rounded">

### Complétude
Aucune valeur importante ne manque

*Ex : chaque signalement a une date*

</div>

<div v-click class="p-3 border rounded">

### Cohérence
La donnée est uniforme entre les systèmes

*Ex : même format de date partout*

</div>

<div v-click class="p-3 border rounded">

### Temporalité
La donnée est à jour

*Ex : statut d'intervention reflète l'état réel*

</div>

<div v-click class="p-3 border rounded">

### Unicité
Pas de doublons

*Ex : un lampadaire = un seul enregistrement*

</div>

<div v-click class="p-3 border rounded">

### Validité
La donnée respecte les règles métier

*Ex : urgence = 1, 2 ou 3 uniquement*

</div>

</div>

<div v-click class="accent-box mt-2">

→ Le nettoyage concret (SQL, staging, déduplication) est traité dans le <a class="module-link" href="https://comem-infradon.onrender.com/03-import-nettoyage/">module 03</a>.

</div>

<div class="footer"><a href="https://firsteigen.com/blog/how-to-build-a-robust-data-infrastructure/">FirstEigen · How to Build a Robust Data Infrastructure (2022)</a></div>

---
layout: default
---

# Combien de problèmes trouvez-vous ?

<div class="text-sm text-gray-500 italic mb-2">Extrait de <code>signalements.xlsx</code> - données brutes du projet</div>

<div class="text-sm">

| id | objet_id | date | description | urgence | technicien |
|----|----------|------|-------------|---------|------------|
| 1 | BAN-042 | 01/03/2023 | banc cassé | 2 | Marie Dupond |
| 2 | | 2023-02-28 | lampadaire éteint | 4 | marie dupond |
| 3 | BAN-042 | 01/03/2023 | banc cassé | 2 | Marie Dupont |
| 4 | LAM-099 | 03/2023 | problème | haute | Jean Martin |

</div>

<v-clicks>

<div class="grid grid-cols-3 gap-2 mt-2" style="font-size: 0.72rem; line-height: 1.3;">
<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Complétude</strong> : <code>objet_id</code> manquant (ligne 2)</div>
<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Cohérence</strong> : 3 formats de date différents (<code>01/03/2023</code>, <code>2023-02-28</code>, <code>03/2023</code>)</div>
<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Validité</strong> : <code>urgence = 4</code> hors domaine (1-3), <code>urgence = "haute"</code> mauvais type</div>
<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Unicité</strong> : lignes 1 et 3 semblent identiques (même objet, même date, même description)</div>
<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Précision</strong> : "Marie Dupond", "marie dupond", "Marie Dupont" : 3 orthographes pour 1 personne</div>
<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Temporalité</strong> : aucun champ de mise à jour : impossible de savoir si les statuts sont à jour</div>
</div>

</v-clicks>

---
layout: default
---

# Où faire respecter l'intégrité ?

<div class="grid grid-cols-2 gap-10 mt-6">

<div v-click>

<img src="/images/02-fondamentaux/ou-integrite.jpg" class="rounded" style="max-height: 80%; object-fit: contain;" />

</div>

<div v-click>

Trois niveaux **complémentaires** : ne pas tout déléguer à un seul

<div class="flex flex-col gap-14 mt-6" style="font-size: 0.78rem; line-height: 1.4;">

<div class="px-3 py-2 border-l-2 border-gray-400 flex items-center gap-3"><div><strong>Côté client</strong><br/>Validation UI : améliore l'expérience, mais contournable</div></div>

<div class="px-3 py-2 border-l-2 border-gray-400 flex items-center gap-3"><div><strong>Application (pipelines ou backend)</strong><br/>Règles métier, transformations, vérifications croisées</div></div>

<div class="px-3 py-2 border-l-2 border-gray-400 flex items-center gap-3"><div><strong>Base de données</strong><br/>Contraintes, types, clés étrangères : dernier filet</div></div>

</div>

</div>

</div>

---
layout: section
---

# ACID - les garanties transactionnelles

<p class="section-subtitle">Ce qu'un système fiable promet : et ce qu'il ne peut pas toujours tenir</p>

---
layout: default
---

# Qu'est-ce qu'une transaction ?

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

Groupe d'opérations traité comme une **unité indivisible**

*Ex : enregistrer un signalement **et** créer l'intervention*

- Succès → **COMMIT**
- Échec → **ROLLBACK** (tout annulé)

</v-clicks>

<div v-click class="accent-box mt-6">

**ACID** définit les garanties qu'un système transactionnel s'engage à respecter.

</div>

</div>

<div>

<img src="/images/02-fondamentaux/transaction.png" class="rounded" style="max-height: 80%; object-fit: contain;" />
<div class="text-xs text-gray-400 mt-1">Source : <a href="https://www.javatpoint.com/dbms-transaction">javatpoint.com</a>
</div>

</div>

</div>

<div class="footer"><a href="https://orimoladekolade.medium.com/understanding-sql-transactions-a-beginners-guide-17649bc54d50">Orimola Dekolade · Understanding SQL Transactions (Medium)</a></div>

---
layout: default
---

# ACID - les 4 propriétés

<div class="grid grid-cols-4 gap-3 mt-4" style="font-size: 0.73rem; line-height: 1.4;">

<div v-click class="p-3 border rounded">

### Atomicité
**Tout ou rien**

Toutes réussissent ou aucune n'est appliquée

*Ex : clôture intervention + mise à jour stock : un échec annule tout*

Crash → rollback automatique

</div>

<div v-click class="p-3 border rounded">

### Cohérence
**État valide → état valide**

Contraintes respectées avant et après

*Ex : intervention impossible pour un objet inexistant*

</div>

<div v-click class="p-3 border rounded">

### Isolation
Pas de visibilité sur les **états intermédiaires**

Ancienne valeur ou nouvelle : jamais un état partiel

→ Niveaux d'isolation : <a class="module-link" href="https://comem-infradon.onrender.com/04-transactions-concurrence/">module 04</a>

</div>

<div v-click class="p-3 border rounded">

### Durabilité
**Survit aux pannes** une fois validée

**Write-Ahead Log (WAL)** : modification écrite dans un journal avant application

Crash → WAL rejoue ou annule les transactions en suspens

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/wal-intro.html">PostgreSQL · Introduction to WAL</a> · <a href="https://www.postgresql.org/docs/current/transaction-iso.html">PostgreSQL · Transaction Isolation</a></div>

---
layout: section
---

# BASE et le théorème CAP

<p class="section-subtitle">Dans un système distribué, cohérence et disponibilité ne coexistent pas</p>

---
layout: default
---

# Système distribué

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

Plusieurs **nœuds** coopèrent via un réseau :

- Réplication entre nœuds
- Scalabilité horizontale : machines supplémentaires, pas plus grosses
- Pannes réseau inévitables en production

</v-clicks>

<div v-click class="accent-box mt-4">

Un PostgreSQL sur une seule machine **n'est pas** un système distribué : CAP et BASE ne s'appliquent qu'aux architectures **multi-nœuds**

</div>

</div>

<div v-click>

### Exemples cloud

| Fournisseur | Services distribués |
|---|---|
| AWS | RDS Multi-AZ, DynamoDB, S3 |
| Azure | Cosmos DB, Azure SQL Hyperscale |
| GCP | Cloud Spanner, Bigtable, BigQuery |

</div>

</div>

---
layout: default
---

# Le théorème CAP

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

Au maximum **deux des trois** propriétés garantissables simultanément :

- <span style="color:var(--heig-red);font-weight:700">C</span><span style="font-weight:700">onsistency</span> : tous les nœuds voient les mêmes données
- <span style="color:var(--heig-red);font-weight:700">A</span><span style="font-weight:700">vailability</span> : toute requête reçoit une réponse (données potentiellement obsolètes)
- <span style="color:var(--heig-red);font-weight:700">P</span><span style="font-weight:700">artition tolerance</span> : fonctionne malgré les coupures réseau

</v-clicks>

<div v-click class="accent-box mt-4">

Partitions réseau inévitables en production → choix réel entre **CP** et **AP**

</div>

</div>

<div>

<img src="/images/02-fondamentaux/cap-theorem.webp" class="rounded" style="max-height: 70%; object-fit: contain;" />

<div class="mt-2 text-sm text-gray-500">

→ PostgreSQL mono-nœud : hors scope CAP · Architectures distribuées : <a class="module-link" href="https://comem-infradon.onrender.com/09-architectures-modernes/">module 09</a>

</div>

</div>

</div>

<div class="footer"><a href="https://hazelcast.com/foundations/distributed-computing/cap-theorem/">Hazelcast · CAP Theorem</a> · <a href="https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html">Kleppmann · Please stop calling databases CP or AP (2015)</a></div>

---
layout: default
---

# BASE : cohérence éventuelle

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

Modèle alternatif à ACID pour systèmes distribués à haute disponibilité :

- <span style="color:var(--heig-red);font-weight:700">B</span><span style="font-weight:700">asically</span> <span style="color:var(--heig-red);font-weight:700">A</span><span style="font-weight:700">vailable</span> : répond toujours (données potentiellement obsolètes)
- <span style="color:var(--heig-red);font-weight:700">S</span><span style="font-weight:700">oft state</span> : état évolue par propagation entre nœuds
- <span style="color:var(--heig-red);font-weight:700">E</span><span style="font-weight:700">ventually consistent</span> : convergence vers le même état sans nouvelles écritures

</v-clicks>

</div>

<div v-click>

### Exemples concrets

| Cas d'usage | Comportement |
|---|---|
| DNS | Propagation en quelques heures |
| Compteur de likes | +1 en mémoire, sync en batch |
| Panier e-commerce | Ajout visible localement en premier |
| Cache CDN | Contenu obsolète jusqu'au prochain refresh |

<div class="accent-box mt-4">

Pas « ACID vs BASE » : **quel niveau de garantie pour quel usage**. Un même système peut combiner les deux.

</div>

</div>

</div>

---
layout: section
---

# OLTP vs OLAP - deux paradigmes

<p class="section-subtitle">Opérationnel ou analytique : deux usages aux contraintes incompatibles</p>

---
layout: default
---

# Deux façons d'utiliser les données

<div class="grid grid-cols-2 gap-6 mt-6">

<div v-click class="p-5 border-l-4 border-red-600">

### OLTP
**Online Transaction Processing**

Gérer les opérations du quotidien

- Beaucoup de petites transactions
- Latence faible, concurrence élevée
- Données actuelles
- Modèle normalisé (3NF)
- ACID requis

*Exemple : enregistrer un signalement, créer une intervention*

</div>

<div v-click class="p-5 border-l-4 border-gray-400">

### OLAP
**Online Analytical Processing**

Analyser et comprendre les données

- Peu de requêtes, mais volumineuses
- Agrégats, tendances, historique
- Données potentiellement décalées
- Modèle dénormalisé (star schema)
- Cohérence éventuelle souvent acceptable

*Exemple : rapport annuel des coûts par type de mobilier*

</div>

</div>

---
layout: default
---

# Quel est le problème ?

<div class="text-sm text-gray-500 italic mb-2"><strong>Scénario</strong> : À 8h45, un technicien essaie d'enregistrer un signalement urgent depuis son téléphone. Au même moment, le responsable a lancé depuis son bureau : `SELECT type_mobilier, SUM(cout), COUNT(*) FROM interventions GROUP BY type_mobilier` - un rapport sur 5 ans de données. La saisie du technicien prend <b>45 secondes</b> au lieu de 2.
</div>


<div class="mt-2 text-sm text-gray-500 italic">Discussion (1 min) : pourquoi ? comment l'éviter ?</div>

<div v-click class="grid grid-cols-2 gap-2 mt-2" style="font-size: 0.72rem; line-height: 1.3;">

<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Problème</strong><br/>La requête analytique (OLAP) scanne toute la table et monopolise des ressources. Elle entre en contention avec les petites écritures OLTP, bloquant les opérations courantes.</div>

<div class="px-2 py-1 border-l-2 border-gray-400"><strong>Solutions</strong><ul class="mt-1 ml-3 list-disc"><li><strong>Read replica</strong> : une copie de la base dédiée aux lectures analytiques</li><li><strong>Séparation OLTP/OLAP</strong> : entrepôt de données distinct (<a class="module-link" href="https://comem-infradon.onrender.com/08-flux-donnees/">module 08</a>)</li><li><strong>Vue matérialisée</strong> : pré-calculer les agrégats la nuit (→ <a class="module-link" href="https://comem-infradon.onrender.com/05-optimisation-indexation/">module 05</a>)</li></ul></div>

</div>

<div class="footer"><a href="https://www.getdbt.com/blog/data-infrastructure">dbt Labs · What is data infrastructure and how to design it (2025)</a></div>

---
layout: section
---

# Abstractions et découplage

<p class="section-subtitle">Ne jamais exposer le schéma physique directement aux consommateurs</p>

---
layout: default
---

# La donnée ne s'expose pas nue

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

<v-clicks>

- **Normalisation** : éviter la redondance

  - Tables reliées par des clés
  - Cohérence et intégrité à l'écriture
  - Jointures nécessaires à la lecture

- **Dénormalisation** : dupliquer pour la performance

  - Données pré-jointes, agrégats précalculés
  - Lectures rapides, moins de jointures
  - Redondance assumée et contrôlée

</v-clicks>



</div>

<div v-click>

<img src="/images/02-fondamentaux/denormalisation.jpg" class="rounded" style="max-height: 85%; object-fit: contain;" />

<div v-click class="accent-box mt-4">

Vues, APIs et modèles dbt = **abstractions stables** entre le schéma physique et les consommateurs

→ Vues en détail : <a class="module-link" href="https://comem-infradon.onrender.com/03-import-nettoyage/">module 03</a>

</div>
</div>

</div>


---
layout: section
---

# Activité

<p class="section-subtitle">Cartographier l'infrastructure de votre projet</p>

---
layout: default
---

# Activité : cartographier votre infrastructure

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### En groupe (20 min)

En vous basant sur votre brief et les données du projet :

<v-clicks>

1. **Qualifier le workload** : OLTP, OLAP ou les deux ? Pour quelle partie ?

2. **Identifier les risques qualité** : colonnes à risque + exemple concret

3. **Choisir un modèle de déploiement** : on-premise, cloud ou hybride pour Yverdon ? Justifier

4. **Identifier les transactions nécessaires** : quelles opérations nécessitent une atomicité ?

</v-clicks>

</div>

<div v-click>

### Mise en commun (10 min)

Chaque groupe présente :

- Classification OLTP / OLAP
- Un risque qualité + mesure préventive
- Modèle de déploiement + justification

</div>

</div>

---
layout: default
---

# Ressources du module

### Articles

<div class="grid grid-cols-2 gap-4 mt-2" style="font-size: 0.8rem;">

<div>

- [dbt Labs · What is data infrastructure and how to design it](https://www.getdbt.com/blog/data-infrastructure) - Poppy, 2025
- [dbt Labs · What is open data infrastructure?](https://www.getdbt.com/blog/what-is-open-data-infrastructure) - Handy, 2025
- [Acceldata · Building Reliable Data Ecosystems](https://www.acceldata.io/blog/data-infrastructure) - 2024
- [Fortra · What Is Data Infrastructure? A Simple Overview](https://www.fortra.com/blog/what-data-infrastructure-simple-overview) - 2024
- [Nate Kupp · The 3 Stages of Data Infrastructure](https://medium.com/@natekupp/getting-started-the-3-stages-of-data-infrastructure-556dac82e825) - 2017
- [FirstEigen · How to Build a Robust Data Infrastructure](https://firsteigen.com/blog/how-to-build-a-robust-data-infrastructure/) - Rao, 2022
- [Kleppmann · Please stop calling databases CP or AP](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html) - 2015

</div>

<div>

### Documentation

- [PostgreSQL · WAL Introduction](https://www.postgresql.org/docs/current/wal-intro.html)
- [PostgreSQL · Transaction Isolation](https://www.postgresql.org/docs/current/transaction-iso.html)
- [PostgreSQL · Materialized Views](https://www.postgresql.org/docs/current/rules-materializedviews.html)

### Livre

<div class="mosaic mosaic-1 mosaic-books mt-2" style="height: 140px;">
  <figure>
    <img src="/images/01-introduction/designing_data_intensive_applications.avif" />
    <figcaption>Kleppmann · Designing Data-Intensive Applications (2017) - ch. 1 et ch. 7</figcaption>
  </figure>
</div>

</div>

</div>

---
layout: end
---

# Questions ?
