---
theme: default
download: true
title: "05 - Optimisation et indexation"
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
    <h1 class="cover-title">05 - Optimisation et indexation</h1>
    <p class="cover-subtitle">Infrastructure de données</p>
    <div style="display: flex; align-items: center; gap: 0.75rem; margin-top: 0.5rem;">
      <a target="_blank" href="https://github.com/MediaComem/comem-infradon" class="cover-email" style="display: flex; align-items: center; gap: 0.25rem;"><carbon-logo-github /> GitHub</a>
      <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/"><img src="https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg" style="height: 12px; opacity: 0.6;" /></a>
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

# Indexation

<p class="section-subtitle">Accélérer les recherches dans une base de données</p>

---
layout: default
---

# Qu'est-ce qu'un index ?

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

* Structure de données qui **accélère les recherches** dans une table.

* Utilisé pour optimiser les requêtes avec `WHERE`, `JOIN`, `ORDER BY`, etc.

<div class="mt-6" style="font-size: 0.85rem; background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 6px; padding: 0.8rem 1rem;">
 Un index en base de données, c'est comme <b>l'index à la fin d'un livre</b> : au lieu de lire toutes les pages une par une, on va directement à l'endroit où se trouve l'information.
</div>
</div>

<div>

<img src="/images/05-optimisation/book_metaphor.jpg" class="rounded" style="max-height: 260px; object-fit: contain;" />
<div class="text-xs text-gray-400 mt-1">Source : <a href="http://www.flickr.com/photos/reedinglessons/2239767394/" target="_blank">flickr.com/photos/reedinglessons</a></div>

</div>

</div>

---
layout: default
---

# Types d'index PostgreSQL

<div class="mt-4" style="font-size: 0.85rem;">

| Type | Description | Syntaxe |
|------|-------------|---------|
| **btree** (défaut) | Ordonné, efficace pour la plupart des requêtes | `CREATE INDEX idx_name ON table(col);` |
| **hash** | Utilisé pour les égalités (`=`) | `CREATE INDEX idx_hash ON table USING hash(col);` |
| **GIN** | Index sur tableaux, JSONB, texte plein | `CREATE INDEX idx_gin ON table USING gin(col);` |
| **GiST / SP-GiST** | Index spatial, texte approximatif, etc. | `CREATE INDEX idx_gist ON table USING gist(col);` |

</div>

<div class="mt-6" style="font-size: 0.85rem; background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 6px; padding: 0.8rem 1rem;">

Un **index composite**, qui porte sur plusieurs colonnes, améliore les performances des requêtes complexes, mais il doit être utilisé avec attention : son efficacité dépend de **l'ordre des colonnes** et il peut alourdir les opérations d'écriture.

```sql
CREATE INDEX idx_composite ON table(col1, col2);
```

</div>

---
layout: default
---

# B-Tree index

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

* Type d'index **par défaut** dans PostgreSQL.

* Fonctionne très bien pour les comparaisons classiques : `=`, `<`, `>`, `BETWEEN`, `ORDER BY`, etc.

* Structure sous forme d'**arbre équilibré** → accès rapide à la donnée triée.

* Très efficace pour des recherches sur des colonnes de type `INT`, `TEXT`, `DATE`, etc.

* Utilisé **automatiquement** pour les clés primaires et uniques.

```sql
CREATE INDEX idx_btree ON ma_table(ma_colonne);
```

</div>

<div>

<img src="/images/05-optimisation/btree.png" class="rounded" style="max-height: 220px; object-fit: contain;" />
<div class="text-xs text-gray-400 mt-1">Source : <a href="https://medium.com/@dhanushkamadushan" target="_blank">Dhanushka Madushan</a></div>

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/indexes-types.html">PostgreSQL · Index Types</a></div>

---
layout: default
---

# Hash index

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

* Optimisé **uniquement** pour les recherches par égalité (`=`).

* Ne peut **pas** être utilisé pour des tris ou intervalles (`<`, `>`, etc.).

* Moins d'espace que B-tree, mais aussi moins polyvalent.

* **Cas d'usage** : recherche exacte sur une clé alternative très utilisée.

```sql
CREATE INDEX idx_hash
  ON ma_table USING hash(ma_colonne);
```

</div>

<div>

<img src="/images/05-optimisation/hash.png" class="rounded" style="max-height: 220px; object-fit: contain;" />
<div class="text-xs text-gray-400 mt-1">Source : <a href="https://sqlpipe.com/blog/b-plus-tree-vs-hash-index" target="_blank">B+ Tree vs Hash Index (and when to use them), SQL Pipe</a></div>

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/indexes-types.html">PostgreSQL · Index Types</a></div>

---
layout: default
---

# GIN index

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

* Très performant pour faire des recherches dans :

  - Du **texte** (avec `to_tsvector`, full-text search)
  - Des colonnes de type **`ARRAY`**
  - Des champs **`JSONB`** avec opérateurs `@>`, `?`, etc.

* Permet de savoir dans quelles lignes un mot ou une valeur apparaît.

* Plus lent à écrire et plus lourd, mais **indispensable pour les recherches complexes**.

```sql
CREATE INDEX idx_gin
  ON ma_table USING gin(ma_colonne);
```

</div>

<div>

<img src="/images/05-optimisation/gin-index.png" class="rounded" style="max-height: 220px; object-fit: contain;" />
<div class="text-xs text-gray-400 mt-1">Generalized Inverted Index (GIN)</div>

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/gin.html">PostgreSQL · GIN Indexes</a></div>

---
layout: default
---

# (SP-)GiST index

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

* Très flexible, peut indexer :

  - Des **données géospatiales** (PostGIS)
  - Des **recherches approximatives** (recherche floue, distances, etc.)

* Structure adaptable à plusieurs types de logique (proximité, similarité…).

* Un peu comme le **"couteau suisse"** des index PostgreSQL.

```sql
CREATE INDEX idx_gist
  ON ma_table USING gist(ma_colonne);
```

</div>

<div>

<img src="/images/05-optimisation/sp-gist.png" class="rounded" style="max-height: 220px; object-fit: contain;" />
<div class="text-xs text-gray-400 mt-1">Source : <a href="https://habr.com/en/articles/318096/" target="_blank">Indexes in PostgreSQL : 6 (SP-GiST), Habr</a></div>

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/spgist.html">PostgreSQL · SP-GiST Indexes</a></div>

---
layout: default
---

# Impact des index

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### ✅ Avantages

- Accélèrent les requêtes avec `WHERE`, `JOIN`, `ORDER BY`, etc.
- Améliorent les performances sur les **grandes tables**
- Réduisent le temps de traitement côté serveur

</div>

<div>

### ❌ Inconvénients

- Ralentissent les écritures (`INSERT`, `UPDATE`, `DELETE`)
- Peuvent devenir **inutiles si mal choisis**
- Consomment de l'**espace disque** supplémentaire

</div>

</div>

---
layout: default
---

# Quand créer un index ?

<div class="mt-4" style="font-size: 0.88rem;">

| Situation | Type recommandé |
|-----------|----------------|
| Tu filtres souvent une colonne dans `WHERE` | **B-Tree** |
| Tu fais des jointures fréquentes sur une colonne | **B-Tree / Hash** |
| Tu travailles sur des plages de dates ou des intervalles | **B-Tree** |
| Tu cherches dans du texte ou des tableaux | **GIN** |
| Tu manipules des données spatiales ou géographiques | **GiST** |

</div>

---
layout: section
---

# EXPLAIN (ANALYZE)

<p class="section-subtitle">Comprendre et optimiser le plan d'exécution d'une requête</p>

---
layout: default
---

# EXPLAIN (ANALYZE)

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

Affiche le **plan d'exécution réel** utilisé par PostgreSQL pour exécuter une requête.

- Montre chaque **étape du traitement** (scan, tri, jointure, etc.)
- Donne les **temps d'exécution réels** pour chaque étape (`Actual Time`)
- Indique le **nombre de lignes** parcourues et retournées
- Permet de repérer les **goulets d'étranglement**
- Montre si des **index sont utilisés** ou non (`Index Scan` vs `Seq Scan`)

> Avec `ANALYZE` : exécute **réellement** la requête (contrairement à `EXPLAIN` seul qui ne fait qu'estimer)

</div>

<div>

```sql
EXPLAIN ANALYZE
  SELECT * FROM ma_table
  WHERE ma_colonne = 'valeur';
```

```
Seq Scan on ma_table
  (cost=0.00..35.50 rows=10 width=244)
  (actual time=0.023..0.112 rows=10 loops=1)
  Filter: (ma_colonne = 'valeur')
  Rows Removed by Filter: 990
Planning Time: 0.082 ms
Execution Time: 0.133 ms
```

Peut être enrichi avec des options :

```sql
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
  SELECT ...;
```

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/sql-explain.html">PostgreSQL · EXPLAIN</a></div>

---
layout: default
---

# EXPLAIN ANALYZE : Lire le résultat

```
Seq Scan on orders  (cost=0.00..2450.00 rows=12 width=80)
                                   ↑        ↑       ↑
                              coût total  lignes  taille ligne (bytes)
  Filter: (user_id = 42)
  Rows Removed by Filter: 99988        ← lignes parcourues pour rien
  actual time=0.021..18.340 rows=12    ← temps réel et lignes retournées
```

<div class="mt-4" style="font-size: 0.85rem;">

| Champ | Signification |
|-------|--------------|
| `cost=X..Y` | Coût estimé (unité arbitraire, pas des ms) : X = démarrage, Y = total |
| `rows` | Nombre de lignes **estimé** par le planificateur |
| `actual time` | Temps d'exécution **réel** en ms |
| `actual rows` | Nombre de lignes **réellement** retournées |
| `Rows Removed by Filter` | Lignes lues mais rejetées → signe qu'un index manque |

</div>



---
layout: default
---

# EXPLAIN ANALYZE : Seq Scan vs Index Scan

<div class="grid grid-cols-2 gap-6 mt-4" style="font-size: 0.8rem;">

<div>

**Sans index** → `Seq Scan` (parcourt toute la table)

```sql
EXPLAIN ANALYZE
  SELECT * FROM orders WHERE user_id = 42;
```

```
Seq Scan on orders
  (cost=0.00..2450.00 rows=12 width=80)
  (actual time=0.021..18.340 rows=12)
  Filter: (user_id = 42)
  Rows Removed by Filter: 99988
Execution Time: 18.361 ms
```

</div>

<div>

**Avec index** → `Index Scan`

```sql
CREATE INDEX idx_orders_user
  ON orders(user_id);

EXPLAIN ANALYZE
  SELECT * FROM orders WHERE user_id = 42;
```

```
Index Scan using idx_orders_user on orders
  (cost=0.42..8.50 rows=12 width=80)
  (actual time=0.021..0.045 rows=12)
  Index Cond: (user_id = 42)
Execution Time: 0.063 ms   -- ~290x plus rapide
```

</div>

</div>

---
layout: default
---

# EXPLAIN ANALYZE : Index ignoré

<div class="mt-4" style="font-size: 0.85rem;">

Un index existant peut être **ignoré** si la requête transforme la colonne :

```sql
-- L'index sur email n'est PAS utilisé
EXPLAIN ANALYZE
  SELECT * FROM users WHERE LOWER(email) = 'alice@example.com';
```

```
Seq Scan on users
  Filter: (lower(email) = 'alice@example.com')
  Rows Removed by Filter: 49999
Execution Time: 15.210 ms
```

**Solution** : créer un **index fonctionnel** sur l'expression exacte

```sql
CREATE INDEX idx_users_email_lower ON users(LOWER(email));
```

```
Index Scan using idx_users_email_lower on users
  Index Cond: (lower(email) = 'alice@example.com')
Execution Time: 0.041 ms
```

</div>

---
layout: default
---

# Bonnes pratiques

<div class="mt-6">

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.2rem; font-size: 0.88rem;">

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 6px; padding: 0.9rem 1rem;">

**Limiter le nombre d'index**

Évite de créer trop d'index → chaque écriture les met à jour.

</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 6px; padding: 0.9rem 1rem;">

**Mesurer avant d'optimiser**

Utilise `EXPLAIN (ANALYZE)` pour mesurer les performances réelles.

</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 6px; padding: 0.9rem 1rem;">

**Nettoyer les index inutilisés**

Supprime les index inutilisés ou redondants.

```sql
DROP INDEX IF EXISTS idx_name;
```

</div>

<div style="background: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 6px; padding: 0.9rem 1rem;">

**Choisir le bon type**

Adapte le type d'index à la **nature des données** et des requêtes.

</div>

</div>

</div>
