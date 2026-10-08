---
theme: pixel
number: "02"
title: "Import et nettoyage"
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

- Composants d'une infrastructure de données
- Modèles de déploiement : sur site, cloud, hybride
- Projet : Service technique d'Yverdon-les-Bains
- Premières observations des fichiers Excel

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-filter /></template>
Qualité des données, puis le pipeline d'import : staging, nettoyage SQL, transfert vers les tables finales.
</Card>

---
layout: section
---

# Qualité des données

---
layout: two-cols
references: "Krantz et Jonker, <em>The True Cost of Poor Data Quality</em>, IBM Think"
---

::title::
# Coût d'une donnée corrompue

::left::

- Coûts cachés dans toute l'organisation
- Propagation à chaque rapport, pipeline, décision
- Corriger à l'entrée : coût 1
- Corriger en production : coût 100

::right::

<Card title="Règle" color="#e92528">
<template #icon><pixelarticons-shield /></template>
Mieux vaut <strong>refuser</strong> une donnée à l'entrée que la corriger en aval.
</Card>

<Card color="#6b7280" tag="note" title="Dans le projet">
<template #icon><pixelarticons-file-alt /></template>
Formats de date multiples, valeurs manquantes, noms saisis à la main, doublons partiels.
</Card>

---
layout: grid
cols: 3
align: stretch
content: center
references: "FirstEigen, <em>How to Build a Robust Data Infrastructure</em> (2022)"
---

# Six dimensions de la qualité

<Card title="Précision">
<template #icon><pixelarticons-target /></template>
Reflète la réalité. <em>Coordonnées GPS correctes.</em>
</Card>
<Card title="Complétude">
<template #icon><pixelarticons-checkbox-on /></template>
Rien d'important ne manque. <em>Chaque signalement a une date.</em>
</Card>
<Card title="Cohérence">
<template #icon><pixelarticons-align-justify /></template>
Uniforme entre les systèmes. <em>Un seul format de date.</em>
</Card>
<Card title="Temporalité">
<template #icon><pixelarticons-clock /></template>
À jour. <em>Le statut reflète l'état réel.</em>
</Card>
<Card title="Unicité">
<template #icon><pixelarticons-duplicate /></template>
Aucun doublon. <em>Un lampadaire, un enregistrement.</em>
</Card>
<Card title="Validité">
<template #icon><pixelarticons-check-double /></template>
Respecte les règles métier. <em>Urgence : 1, 2 ou 3.</em>
</Card>

---
layout: default
class: compact
---

# Exercice : *signalements*

`signalements`

| id | objet_id | date | description | urgence | technicien |
|---|---|---|---|---|---|
| 1 | BAN-042 | 01/03/2023 | banc cassé | 2 | Marie Dupond |
| 2 | | 2023-02-28 | lampadaire éteint | 4 | marie dupond |
| 3 | BAN-042 | 01/03/2023 | banc cassé | 2 | Marie Dupont |
| 4 | LAM-099 | 03/2023 | problème | haute | Jean Martin |

<v-click>

| Dimension | Problème |
|---|---|
| Complétude | `objet_id` manquant, ligne 2 |
| Cohérence | Trois formats de date |
| Validité | `urgence` à `4` hors domaine, `haute` mauvais type |
| Unicité | Lignes 1 et 3 identiques |
| Précision | Trois orthographes pour une même personne |
| Temporalité | Aucune date de mise à jour du statut |

</v-click>

---
layout: default
---

# Sources d'incohérences

- **Saisie libre** : chacun·e invente ses conventions
- **Évolution** : les pratiques changent, les anciennes données restent
- **Plusieurs contributeur·rice·s** : personne ne synchronise
- **Outil inadapté** : Excel n'impose ni type ni format
- **Urgence** : on corrigera plus tard, sans jamais le faire

<Card title="Cause structurelle" color="#e92528">
<template #icon><pixelarticons-alert /></template>
Pas de mauvaise volonté : c'est l'<strong>absence de contraintes à l'entrée</strong> qui produit les incohérences.
</Card>

---
layout: default
class: compact
---

# Inventaire des incohérences du projet

| Problème | Colonne | Exemples |
|---|---|---|
| Formats de date | `date`, `date_installation` | `12.03.2022` · `2022-03-12` · `mars 2022` |
| Casse et orthographe | `type`, `materiau` | `banc` · `Banc` · `banc public` · `metal` |
| Identifiants | `id` | `B-001` · `B_1` · `1001` |
| Personnes en texte libre | `technicien` | `Jean-Marc` · `JM` · `Jean-Marc Bonvin` |
| Coûts | `cout_materiel` | `120` · `CHF 120.-` · `gratuit` · vide |
| Durées | `duree` | `1h30` · `30 min` · `une matinée` |
| GPS | `latitude`, `longitude` | `NULL` (~8%) · `46.78` |
| Liens en texte libre | `objet` | `le banc devant Place Pestalozzi` |
| Téléphones | `telephone` | `024 423 12 34` · `+41 21 456 78 90` |

Chaque problème appelle une **décision** : normaliser, imputer, exclure ou documenter.

---
layout: image-right
image: /images/02/ou-integrite.jpg
backgroundSize: contain
---

# Niveaux d'intégrité

- **Client** : validation à la saisie, contournable
- **Application** : règles métier, vérifications croisées
- **Base de données** : types, contraintes, clés étrangères
- Trois niveaux complémentaires
- La base reste le **dernier filet**

---
layout: section
---

# Modéliser avant d'importer

---
layout: grid
cols: 3fr 1fr 3fr 1fr 3fr 1fr 3fr
align: stretch
content: center
clicks: 3
---

# Pipeline d'import

<Card title="Données brutes" :at="0">
<template #icon><pixelarticons-file-alt /></template>
Fichiers Excel exportés en CSV
</Card>
<pixelarticons-arrow-right v-click="1" class="text-3xl self-center" />
<Card title="Staging" :at="1">
<template #icon><pixelarticons-inbox /></template>
Tout en <code>TEXT</code>, sans contrainte
</Card>
<pixelarticons-arrow-right v-click="2" class="text-3xl self-center" />
<Card title="Nettoyage" :at="2">
<template #icon><pixelarticons-filter /></template>
<code>CASE</code>, <code>TRIM</code>, <code>TO_DATE</code>, <code>COALESCE</code>
</Card>
<pixelarticons-arrow-right v-click="3" class="text-3xl self-center" />
<Card title="Production" :at="3">
<template #icon><pixelarticons-database /></template>
Types, clés étrangères, <code>CHECK</code>
</Card>

---
layout: two-cols
---

::title::
# Ordre des étapes

::left::

### À éviter

- Charger dans des tables improvisées
- Tenter les premières requêtes
- Découvrir que les jointures sont impossibles
- Tout recommencer

::right::

### À faire

- Définir la structure cible : MCD, MLD, MPD
- Construire le nettoyage pour l'atteindre
- Documenter chaque décision

---
layout: default
class: compact
---

# Décisions de modélisation

| Champ brut | Problème | Décision |
|---|---|---|
| `date` | Quatre formats | `CASE` et `TO_DATE()` vers `DATE` |
| `cout_materiel` | `CHF 120.-`, `gratuit`, vide | Chiffres seuls · `gratuit` en `0` · vide en `NULL` |
| `duree` | `1h30`, `une matinée` | Minutes en `INTEGER`, convention documentée |
| `type` | `banc`, `Banc`, `banc public` | `LOWER(TRIM())` puis `CASE` |
| `technicien` | `JM`, `Jean-Marc` | Table de correspondance vers `technicien_id` |
| `latitude` | `NULL`, `46.78` | Garder `NULL`, signaler l'imprécision |
| `objet` | Aucun identifiant | Rapprochement lieu et type vers `mobilier_id` |

<Card title="Guide de nettoyage">
<template #icon><logos-github-icon /></template>
<a href="https://github.com/MediaComem/comem-infradon/blob/main/projet/aide-nettoyage.md">projet/aide-nettoyage.md</a> : export Excel, connexion, import des quatre fichiers.
</Card>

---
layout: section
---

# Staging

---
layout: two-cols
references: "PostgreSQL, <em>CREATE SCHEMA</em>, <em>CREATE TABLE</em>"
---

::title::
# Table de staging

::left::

- Miroir exact du fichier source
- Toutes les colonnes en `TEXT`
- Ni clé étrangère, ni `CHECK`, ni `NOT NULL`
- Aucune ligne rejetée à l'import
- Un schéma dédié : `staging`

::right::

```sql
CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.inventaire (
  id                TEXT,
  type              TEXT,
  materiau          TEXT,
  lieu              TEXT,
  latitude          TEXT,
  longitude         TEXT,
  date_installation TEXT,
  etat              TEXT,
  remarques         TEXT
);
```

---
layout: default
---

# Table permanente ou temporaire

| | `CREATE TABLE staging.x` | `CREATE TEMP TABLE x` |
|---|---|---|
| Survit à la déconnexion | Oui | Non |
| Partageable | Oui | Non |
| Travail sur plusieurs séances | Oui | Non |
| Suppression automatique | Non | Oui |
| Usage | Projet, pipeline | Test rapide |

<Card title="Pour le projet" color="#16a34a" tag="tip">
<template #icon><pixelarticons-check /></template>
Table <strong>permanente</strong> dans le schéma <code>staging</code> : le pipeline se construit sur plusieurs semaines.
</Card>

---
layout: two-cols
references: "PostgreSQL, <em>COPY</em>"
---

::title::
# Import avec COPY

::left::

- Fichiers CSV dans le dossier `data/`
- Dossier monté dans le conteneur
- `COPY` lit le fichier côté serveur
- `HEADER true` : ignorer la ligne d'en-tête

::right::

```yaml
# docker-compose.yml
volumes:
  - ./data:/data
```

```sql
COPY staging.inventaire
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true,
      DELIMITER ',', ENCODING 'UTF8');
```

---
layout: two-cols
---

::title::
# Import direct

::left::

### Situation

> « J'ai importé `interventions.csv` directement dans la table finale. 47 lignes sur 150 sont refusées. »

### La question

Pourquoi, et comment l'éviter ?

::right::

<v-click>

| Valeur | Attendu |
|---|---|
| `CHF 120.-` | `NUMERIC` |
| `mars 2023` | `DATE` |
| `JM` | Clé étrangère valide |

</v-click>

<v-click>

- Les contraintes rejettent toute ligne non conforme
- Passer par la staging, nettoyer, valider
- Puis `INSERT INTO ... SELECT`

</v-click>

---
layout: section
---

# Nettoyage SQL

---
layout: two-cols
references: "PostgreSQL, <em>Conditional Expressions</em>"
---

::title::
# Syntaxe : CASE

::left::

- Le `if` et le `switch` de SQL
- Forme simple : compare une valeur
- Forme générale : teste des conditions
- Retourne une **valeur**
- `ELSE` absent : `NULL`

::right::

```sql
-- Forme simple
CASE expression
  WHEN valeur1 THEN resultat1
  WHEN valeur2 THEN resultat2
  ELSE resultat_par_defaut
END

-- Forme générale
CASE
  WHEN condition1 THEN resultat1
  WHEN condition2 THEN resultat2
  ELSE resultat_par_defaut
END
```

---
layout: two-cols
---

::title::
# Exemple : *type* de mobilier

::left::

### Besoins

> « Dans l'inventaire, on trouve `banc`, `Banc`, `banc public`. C'est le même type. »

### La question

Comment ramener chaque variante à une seule valeur ?

::right::

<v-click>

```sql
SELECT
  CASE LOWER(TRIM(type))
    WHEN 'banc'           THEN 'banc'
    WHEN 'banc public'    THEN 'banc'
    WHEN 'lampadaire'     THEN 'lampadaire'
    WHEN 'lampadaire led' THEN 'lampadaire'
    ELSE NULL
  END AS type
FROM staging.inventaire;
```

</v-click>

<v-click>

- Normaliser avant de comparer
- Une ligne `WHEN` par variante
- `NULL` signale une variante oubliée

</v-click>

---
layout: two-cols
---

::title::
# Exemple : formats de *date*

::left::

### Besoins

> « Certaines dates sont écrites `12.03.2022`, d'autres `2022-03-12`. »

### La question

Comment convertir les deux formats en `DATE` ?

::right::

<v-click>

```sql
SELECT
  CASE
    WHEN date LIKE '%.%.%'
      THEN TO_DATE(date, 'DD.MM.YYYY')
    WHEN date LIKE '____-__-__'
      THEN TO_DATE(date, 'YYYY-MM-DD')
    ELSE NULL
  END AS date
FROM staging.signalements;
```

</v-click>

<v-click>

- Forme générale : une condition par format
- `LIKE` reconnaît le format
- `TO_DATE` convertit selon un masque

</v-click>

---
layout: two-cols
references: "PostgreSQL, <em>String Functions</em>"
---

::title::
# Chaînes de caractères

::left::

- `TRIM` : espaces en début et en fin
- `LOWER` : tout en minuscules
- Combinées avant toute comparaison
- `LIKE` : comparaison à un motif
- `%` : n'importe quoi · `_` : un caractère

::right::

```sql
TRIM('  banc  ')      -- 'banc'
LOWER('Banc Public')  -- 'banc public'
LOWER(TRIM(type))

date LIKE '%.%.%'     -- des points
date LIKE '____-__-__' -- ISO
type LIKE 'banc%'     -- début
```

---
layout: two-cols
references: "PostgreSQL, <em>Conditional Expressions</em>"
---

::title::
# Valeurs vides

::left::

- `NULLIF(a, b)` : `NULL` si `a` égale `b`
- Chaîne vide transformée en `NULL`
- `COALESCE(a, b)` : première valeur non nulle
- Valeur par défaut si `NULL`

::right::

```sql
NULLIF(TRIM(urgence), '')

COALESCE(statut, 'en_attente')

-- '' devient NULL, puis 'en_attente'
COALESCE(
  NULLIF(TRIM(statut), ''),
  'en_attente'
)
```

---
layout: two-cols
references: "PostgreSQL, <em>Data Type Formatting Functions</em>"
---

::title::
# Conversion de types

::left::

- `TO_DATE` : texte vers date, selon un masque
- `::NUMERIC` : texte vers nombre
- `REGEXP_REPLACE` : garder les seuls chiffres
- Conversion impossible : erreur

::right::

```sql
TO_DATE('12.03.2022', 'DD.MM.YYYY')
TO_DATE('2022-03-12', 'YYYY-MM-DD')

'120'::NUMERIC
NULLIF(latitude, '')::NUMERIC(9,6)

-- 'CHF 120.-' devient 120
REGEXP_REPLACE(
  cout, '[^0-9]', '', 'g'
)::INTEGER
```

---
layout: two-cols
references: "PostgreSQL, <em>Window Functions</em>"
---

::title::
# Syntaxe : ROW_NUMBER

::left::

- Fonction de **fenêtrage**
- Numérote les lignes de chaque groupe
- `PARTITION BY` : définit les groupes
- `ORDER BY` : ordre dans le groupe
- Lignes conservées, contrairement à `GROUP BY`

::right::

```sql
ROW_NUMBER() OVER (
  PARTITION BY colonne1, colonne2
  ORDER BY colonne3
)
```

---
layout: two-cols
---

::title::
# Exemple : doublons de l'*inventaire*

::left::

### Besoins

> « Le même banc a été saisi deux fois, avec un identifiant différent. »

### La question

Comment ne garder qu'une ligne par objet ?

::right::

<v-click>

```sql
WITH numerotees AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY LOWER(TRIM(lieu)),
                   LOWER(TRIM(type))
      ORDER BY id
    ) AS numero
  FROM staging.inventaire
)
SELECT * FROM numerotees
WHERE numero = 1;
```

</v-click>

<v-click>

- Un groupe par lieu et type
- Numéro 1 : première occurrence
- Les autres lignes sont les doublons

</v-click>

---
layout: section
---

# Import rejouable

---
layout: two-cols
---

::title::
# Idempotence

::left::

- **Idempotente** : N exécutions, même résultat qu'une
- Lecture : toujours idempotente
- Suppression : idempotente
- `INSERT` : **non** idempotent par défaut

::right::

<Card title="Réessais" color="#d97706" tag="warning">
<template #icon><pixelarticons-reload /></template>
Le réseau coupe après l'écriture, avant la confirmation. Le client réessaie : sans idempotence, la ligne est insérée deux fois.
</Card>

<Card title="Import" color="#6b7280" tag="note">
<template #icon><pixelarticons-repeat /></template>
Un script d'import se relance souvent. Il doit donner le même résultat à chaque fois.
</Card>

---
layout: two-cols
class: compact
---

::title::
# Exemple : signalements en double

::left::

### Situation

> « L'application mobile a mal capté. Mon signalement de fontaine apparaît trois fois. »

`signalements`

| id | objet_id | date | description |
|---|---|---|---|
| 201 | FONT-012 | 2024-03-15 | fontaine cassée |
| 202 | FONT-012 | 2024-03-15 | fontaine cassée |
| 203 | FONT-012 | 2024-03-15 | fontaine cassée |

::right::

<v-click>

```sql
ALTER TABLE signalements
  ADD CONSTRAINT signalement_unique
  UNIQUE (objet_id, date, description);

INSERT INTO signalements
  (objet_id, date, description)
VALUES ('FONT-012', '2024-03-15',
        'fontaine cassée')
ON CONFLICT DO NOTHING;
```

</v-click>

<v-click>

- Une contrainte définit le doublon
- `ON CONFLICT DO NOTHING` ignore le réessai
- Un réessai ne crée plus de ligne

</v-click>

---
layout: section
---

# De la staging à la production

---
layout: two-cols
references: "PostgreSQL, <em>INSERT</em>"
---

::title::
# Syntaxe : INSERT INTO ... SELECT

::left::

- Transfert en une seule requête
- `SELECT` applique les transformations
- `WHERE` écarte les lignes invalides
- `ON CONFLICT` : import rejouable

::right::

```sql
INSERT INTO table_finale (col1, col2)
SELECT
  transformation1 AS col1,
  transformation2 AS col2
FROM staging.table_brute
WHERE condition_de_validite
ON CONFLICT (id) DO NOTHING;
```

---
layout: two-cols
---

::title::
# Validation avant transfert

::left::

- Compter chaque valeur distincte
- Repérer les variantes non traitées
- Beaucoup de `NULL` après `CASE` : mapping incomplet
- Vérifier, puis transférer

::right::

```sql
SELECT type, COUNT(*)
FROM staging.inventaire
GROUP BY type
ORDER BY COUNT(*) DESC;

SELECT date_installation, COUNT(*)
FROM staging.inventaire
GROUP BY date_installation
ORDER BY 2 DESC
LIMIT 10;
```

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# Travail pratique · Semaine 2

::left::

### J0 · Exploration et modélisation

1. Noter formats de date, variantes de `type`
2. Repérer identifiants suspects, colonnes vides
3. Dessiner le MCD et le MLD

::right::

### J1 · Import et nettoyage

1. Créer le schéma `staging`, tout en `TEXT`
2. Importer les quatre fichiers avec `COPY`
3. Écrire le MPD : `CREATE TABLE` finaux
4. Nettoyer, puis `INSERT INTO ... SELECT`

<Card color="#6b7280" tag="note" title="Guide">
<template #icon><pixelarticons-book-open /></template>
<a href="https://github.com/MediaComem/comem-infradon/blob/main/projet/aide-nettoyage.md">projet/aide-nettoyage.md</a>
</Card>

---
layout: default
---

# Ressources

- [PostgreSQL · COPY](https://www.postgresql.org/docs/current/sql-copy.html)
- [PostgreSQL · Fonctions sur les chaînes](https://www.postgresql.org/docs/current/functions-string.html)
- [PostgreSQL · Formatage et TO_DATE](https://www.postgresql.org/docs/current/functions-formatting.html)
- [PostgreSQL · Window Functions](https://www.postgresql.org/docs/current/tutorial-window.html)
- [PostgreSQL · INSERT et ON CONFLICT](https://www.postgresql.org/docs/current/sql-insert.html)

<Card title="Prochain cours" color="#e92528" footer="cours 03 · Transactions et concurrence">
<template #icon><pixelarticons-arrow-right /></template>
ACID, accès simultanés, niveaux d'isolation, verrous.
</Card>
