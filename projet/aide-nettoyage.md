# Aide au nettoyage - Service technique Yverdon

Guide de référence pour l'import et le nettoyage des données. Il explique **comment** procéder, pas **quoi** écrire.

---

## Stratégie

```
Excel (4 fichiers)
      ↓  COPY (via volume Docker)
schema staging  (tout en TEXT, aucune contrainte)
      ↓  INSERT INTO ... SELECT + transformations SQL
schema public   (types corrects, clés étrangères, données normalisées)
```

---

## Étape 1 - Créer le schéma et les tables staging

```sql
CREATE SCHEMA IF NOT EXISTS staging;
```

Les tables staging reprennent exactement les colonnes des fichiers Excel, **tout en TEXT** :

```sql
CREATE TABLE staging.inventaire_mobilier (
    id TEXT, type TEXT, materiau TEXT, lieu TEXT,
    latitude TEXT, longitude TEXT,
    date_installation TEXT, etat TEXT, remarques TEXT
);

CREATE TABLE staging.signalements (
    date TEXT, signale_par TEXT, objet TEXT,
    description TEXT, urgence TEXT, statut TEXT
);

CREATE TABLE staging.interventions (
    date TEXT, objet TEXT, type_intervention TEXT,
    technicien TEXT, duree TEXT, cout_materiel TEXT, remarques TEXT
);

CREATE TABLE staging.fournisseurs (
    entreprise TEXT, contact TEXT, telephone TEXT,
    email TEXT, type_materiel TEXT, remarques TEXT
);
```

---

## Étape 2 - Exporter les Excel et importer dans PostgreSQL

### 2.1 Exporter en CSV

Pour chacun des 4 fichiers Excel :
- `Fichier` → `Enregistrer sous` → **CSV UTF-8**
- Placer dans `projet/data/`

> Excel sur Windows produit parfois du `windows-1252` - choisir explicitement **CSV UTF-8**.

### 2.2 Ouvrir un terminal psql

**VS Code** (terminal intégré) :
```bash
docker exec -it infradon-postgres psql -U infradon -d infradon
```

**Docker Desktop** : conteneur `infradon-postgres` → onglet **Terminal** → `psql -U infradon -d infradon`

### 2.3 Importer avec COPY

Le dossier `projet/data/` est monté sous `/data/` dans le conteneur.

```sql
COPY staging.inventaire_mobilier
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Répéter pour signalements, interventions, fournisseurs_contacts
```

**Vérifier :**
```sql
SELECT COUNT(*) FROM staging.inventaire_mobilier;  -- ~120
SELECT COUNT(*) FROM staging.signalements;         -- ~200
SELECT COUNT(*) FROM staging.interventions;        -- ~150
SELECT COUNT(*) FROM staging.fournisseurs;         -- ~15
```

---

## Étape 3 - Explorer les données brutes

Avant de nettoyer, comprendre ce qu'il y a dans les données.

```sql
-- Types de mobilier
SELECT type, COUNT(*) FROM staging.inventaire_mobilier GROUP BY type ORDER BY 2 DESC;

-- Matériaux
SELECT materiau, COUNT(*) FROM staging.inventaire_mobilier GROUP BY materiau;

-- Formats de date
SELECT date_installation, COUNT(*)
FROM staging.inventaire_mobilier
GROUP BY date_installation ORDER BY 2 DESC LIMIT 20;

-- Coûts
SELECT cout_materiel, COUNT(*) FROM staging.interventions GROUP BY cout_materiel ORDER BY 2 DESC;

-- Durées
SELECT duree, COUNT(*) FROM staging.interventions GROUP BY duree;

-- Techniciens
SELECT technicien, COUNT(*) FROM staging.interventions GROUP BY technicien ORDER BY 2 DESC;

-- Doublons potentiels (même lieu + type)
SELECT lieu, type, COUNT(*) FROM staging.inventaire_mobilier
GROUP BY lieu, type HAVING COUNT(*) > 1;
```

---

## Étape 4 - Nettoyage SQL : les patterns à appliquer

### Normaliser du texte (casse, espaces)

```sql
LOWER(TRIM(colonne))
```

### Mapper des valeurs vers une valeur normalisée

```sql
CASE LOWER(TRIM(colonne))
    WHEN 'valeur_brute_1' THEN 'valeur_propre'
    WHEN 'valeur_brute_2' THEN 'valeur_propre'
    ELSE NULL
END
```

### Détecter des formats de date avec LIKE

```sql
CASE
    WHEN colonne LIKE '%.%.%'    THEN TO_DATE(colonne, 'DD.MM.YYYY')
    WHEN colonne LIKE '____-__-__' THEN TO_DATE(colonne, 'YYYY-MM-DD')
    ELSE NULL
END
```

### Nettoyer les coûts

```sql
-- Supprimer tout sauf les chiffres, puis caster
REGEXP_REPLACE(cout_materiel, '[^0-9]', '', 'g')::INTEGER
```

### Gérer les valeurs vides

```sql
NULLIF(TRIM(colonne), '')          -- '' → NULL
COALESCE(colonne, 'valeur_defaut') -- NULL → valeur par défaut
```

### Dédoublonner

```sql
ROW_NUMBER() OVER (
    PARTITION BY LOWER(TRIM(col1)), LOWER(TRIM(col2))
    ORDER BY id
)
-- Garder uniquement les lignes où ROW_NUMBER() = 1
```

---

## Étape 5 - Charger les tables de production

Pattern général :

```sql
INSERT INTO public.table_finale (col1, col2, ...)
SELECT
    transformation1,
    transformation2,
    ...
FROM staging.table_brute
WHERE condition_de_validite
ON CONFLICT (id) DO NOTHING;
```

Ordre d'insertion important (respecter les FK) :
1. `technicien` (référencé par `intervention`)
2. `fournisseur`
3. `mobilier`
4. `signalement`
5. `intervention`

---

## Limites connues

| Problème | Impact | Décision suggérée |
|---|---|---|
| `objet` en texte libre dans signalements et interventions | Impossible de joindre automatiquement à `mobilier` | Documenter la limite |
| GPS arrondis (~20%) | Localisation imprécise | Conserver, noter la précision |
| GPS manquants (~8%) | Pas de cartographie | NULL accepté |
| `stagiaire` sans nom | Technicien inconnu | NULL dans `technicien_id` |
