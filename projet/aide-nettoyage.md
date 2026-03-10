# Aide nettoyage - Service technique Yverdon

Ce document est un guide pas-à-pas pour nettoyer les 4 fichiers Excel du projet et charger les données dans PostgreSQL. Il complète le cours 03.

---

## Vue d'ensemble de la stratégie

```
Excel (4 fichiers)
      ↓  COPY (via volume Docker)
schema staging  (tout en TEXT, aucune contrainte)
      ↓  INSERT INTO ... SELECT + transformations SQL
schema public   (types corrects, clés étrangères, données normalisées)
```

---

## Étape 0 — Préparer et importer les CSV

### 0.1 Exporter les fichiers Excel en CSV

Pour chacun des 4 fichiers Excel :
- Ouvrir le fichier dans Excel
- `Fichier` → `Enregistrer sous` → Format : **CSV UTF-8**
- Placer le fichier dans le dossier `projet/data/` du projet

> Excel sur Windows produit parfois du `windows-1252`. Choisir explicitement **CSV UTF-8** pour préserver les accents.

### 0.2 Ouvrir un terminal psql dans le conteneur

**Option A — VS Code** (terminal intégré) :

```bash
docker exec -it infradon-postgres psql -U infradon -d infradon
```

**Option B — Docker Desktop** : conteneur `infradon-postgres` → onglet **Terminal**, puis :

```bash
psql -U infradon -d infradon
```

### 0.3 Importer les 4 fichiers avec COPY

Le dossier `projet/data/` est monté sous `/data/` dans le conteneur.

```sql
COPY staging.inventaire_mobilier
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY staging.signalements
FROM '/data/signalements.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY staging.interventions
FROM '/data/interventions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY staging.fournisseurs
FROM '/data/fournisseurs_contacts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
```

**Vérifier :**

```sql
SELECT COUNT(*) FROM staging.inventaire_mobilier;  -- ~120
SELECT COUNT(*) FROM staging.signalements;         -- ~200
SELECT COUNT(*) FROM staging.interventions;        -- ~150
SELECT COUNT(*) FROM staging.fournisseurs;         -- ~15
```

---

## Étape 1 - Créer le schéma staging

```sql
CREATE SCHEMA IF NOT EXISTS staging;
```

---

## Étape 2 - Tables staging (tout en TEXT)

### inventaire_mobilier

```sql
CREATE TABLE staging.inventaire_mobilier (
    id            TEXT,
    type          TEXT,
    materiau      TEXT,
    lieu          TEXT,
    latitude      TEXT,
    longitude     TEXT,
    date_installation TEXT,
    etat          TEXT,
    remarques     TEXT
);
```

### signalements

```sql
CREATE TABLE staging.signalements (
    date          TEXT,
    signale_par   TEXT,
    objet         TEXT,
    description   TEXT,
    urgence       TEXT,
    statut        TEXT
);
```

### interventions

```sql
CREATE TABLE staging.interventions (
    date              TEXT,
    objet             TEXT,
    type_intervention TEXT,
    technicien        TEXT,
    duree             TEXT,
    cout_materiel     TEXT,
    remarques         TEXT
);
```

### fournisseurs_contacts

```sql
CREATE TABLE staging.fournisseurs (
    entreprise    TEXT,
    contact       TEXT,
    telephone     TEXT,
    email         TEXT,
    type_materiel TEXT,
    remarques     TEXT
);
```

---

## Étape 3 - Importer les fichiers CSV avec \copy

Exporter chaque onglet Excel en CSV (UTF-8, séparateur virgule), puis dans psql :

```sql
\copy staging.inventaire_mobilier FROM 'chemin/inventaire_mobilier.csv'
  WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy staging.signalements FROM 'chemin/signalements.csv'
  WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy staging.interventions FROM 'chemin/interventions.csv'
  WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy staging.fournisseurs FROM 'chemin/fournisseurs_contacts.csv'
  WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
```

Vérification rapide :

```sql
SELECT COUNT(*) FROM staging.inventaire_mobilier;   -- ~121 lignes
SELECT COUNT(*) FROM staging.signalements;           -- ~203 lignes
SELECT COUNT(*) FROM staging.interventions;          -- ~150 lignes
SELECT COUNT(*) FROM staging.fournisseurs;           -- 14 lignes
```

---

## Étape 4 - Inventaire des problèmes

Avant de nettoyer, observer les données brutes.

### Types de mobilier

```sql
SELECT type, COUNT(*) FROM staging.inventaire_mobilier GROUP BY type ORDER BY 2 DESC;
-- banc, Banc, banc public, lampadaire, Lampadaire, lampadaire LED, ...
```

### Matériaux

```sql
SELECT materiau, COUNT(*) FROM staging.inventaire_mobilier GROUP BY materiau;
-- métal, metal, Métal, bois, pierre, Pierre, LED, sodium, ...
```

### Formats de date

```sql
SELECT date_installation, COUNT(*)
FROM staging.inventaire_mobilier
GROUP BY date_installation
ORDER BY 2 DESC
LIMIT 20;
-- 15.04.2018, 2020-06-12, mars 2022, 2014, ...
```

### Coûts

```sql
SELECT cout_materiel, COUNT(*)
FROM staging.interventions
GROUP BY cout_materiel
ORDER BY 2 DESC;
-- 120, CHF 120.-, 120.-, gratuit, garantie, (vide)
```

### Durées

```sql
SELECT duree, COUNT(*) FROM staging.interventions GROUP BY duree;
-- 1h, 2h, 1h30, 30 min, une matinée, une journée
```

### Techniciens

```sql
SELECT technicien, COUNT(*) FROM staging.interventions GROUP BY technicien ORDER BY 2 DESC;
-- Jean-Marc, JM, Jean-Marc Bonvin, Alves Pedro, P. Alves, Pedro, stagiaire, Koffi Marc
```

### Doublons inventaire

```sql
-- Même lieu + même type, IDs différents
SELECT lieu, type, COUNT(*) AS n
FROM staging.inventaire_mobilier
GROUP BY lieu, type
HAVING COUNT(*) > 1;
```

### GPS manquants ou arrondis

```sql
SELECT COUNT(*) FROM staging.inventaire_mobilier WHERE latitude IS NULL OR latitude = '';
-- GPS arrondis (seulement 2 décimales)
SELECT * FROM staging.inventaire_mobilier
WHERE latitude ~ '^\d+\.\d{1,2}$';
```

---

## Étape 5 - Nettoyage par table

### 5.1 inventaire_mobilier

#### Normaliser le type

Les variantes présentes dans les données :

| Brut | Normalisé |
|------|-----------|
| banc, Banc, banc public | banc |
| lampadaire, Lampadaire, lampadaire sodium | lampadaire |
| Lampadaire LED, lampadaire LED, lampadaire led | lampadaire |
| poubelle, Poubelle, corbeille, poubelle tri | poubelle |
| fontaine, Fontaine, fontaine publique | fontaine |
| borne recharge EV, Borne recharge, borne EV | borne |
| panneau affichage, Panneau, panneau info | panneau |

```sql
SELECT id,
    CASE
        WHEN LOWER(TRIM(type)) LIKE 'banc%'       THEN 'banc'
        WHEN LOWER(TRIM(type)) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(type)) LIKE 'poubelle%'
          OR LOWER(TRIM(type)) = 'corbeille'       THEN 'poubelle'
        WHEN LOWER(TRIM(type)) LIKE 'fontaine%'    THEN 'fontaine'
        WHEN LOWER(TRIM(type)) LIKE '%borne%'      THEN 'borne'
        WHEN LOWER(TRIM(type)) LIKE '%panneau%'    THEN 'panneau'
        ELSE LOWER(TRIM(type))
    END AS type_norm
FROM staging.inventaire_mobilier;
```

#### Normaliser le matériau

```sql
SELECT materiau,
    CASE
        WHEN LOWER(TRIM(materiau)) IN ('métal', 'metal') THEN 'métal'
        WHEN LOWER(TRIM(materiau)) = 'pierre'             THEN 'pierre'
        WHEN LOWER(TRIM(materiau)) = 'bois'               THEN 'bois'
        WHEN LOWER(TRIM(materiau)) = 'béton'              THEN 'béton'
        WHEN LOWER(TRIM(materiau)) = 'led'                THEN 'LED'
        WHEN LOWER(TRIM(materiau)) = 'sodium'             THEN 'sodium'
        WHEN materiau IS NULL OR TRIM(materiau) = ''      THEN NULL
        ELSE LOWER(TRIM(materiau))
    END AS materiau_norm
FROM staging.inventaire_mobilier;
```

#### Normaliser l'état

```sql
CASE
    WHEN LOWER(TRIM(etat)) IN ('bon', 'bonne')    THEN 'bon'
    WHEN LOWER(TRIM(etat)) IN ('usé', 'use')      THEN 'usé'
    WHEN LOWER(TRIM(etat)) LIKE 'à remplacer%'    THEN 'à remplacer'
    WHEN etat IS NULL OR TRIM(etat) = ''          THEN NULL
    ELSE LOWER(TRIM(etat))
END AS etat_norm
```

#### Parser les dates (4 formats)

```sql
CASE
    -- Format CH : 15.04.2018
    WHEN date_installation ~ '^\d{2}\.\d{2}\.\d{4}$'
        THEN TO_DATE(date_installation, 'DD.MM.YYYY')
    -- Format ISO : 2020-06-12
    WHEN date_installation ~ '^\d{4}-\d{2}-\d{2}$'
        THEN TO_DATE(date_installation, 'YYYY-MM-DD')
    -- Format texte : "mars 2022" (prendre le 1er du mois)
    WHEN date_installation ~ '^[a-zA-ZÀ-ÿ]+ \d{4}$'
        THEN TO_DATE('01 ' || date_installation, 'DD TMMonth YYYY')
    -- Année seule : "2014" (prendre le 1er janvier)
    WHEN date_installation ~ '^\d{4}$'
        THEN TO_DATE(date_installation || '-01-01', 'YYYY-MM-DD')
    ELSE NULL
END AS date_installation_parsed
```

> Astuce : pour le format texte avec les mois en français, PostgreSQL doit avoir `lc_time` en français, ou utiliser un CASE supplémentaire pour chaque mois.

#### Alternativement, mois français avec CASE

```sql
CASE
    WHEN date_installation ~ '^[a-zA-ZÀ-ÿ]+ \d{4}$' THEN
        TO_DATE(
            '01-' ||
            CASE SPLIT_PART(LOWER(date_installation), ' ', 1)
                WHEN 'janvier'   THEN '01'
                WHEN 'février'   THEN '02'
                WHEN 'mars'      THEN '03'
                WHEN 'avril'     THEN '04'
                WHEN 'mai'       THEN '05'
                WHEN 'juin'      THEN '06'
                WHEN 'juillet'   THEN '07'
                WHEN 'août'      THEN '08'
                WHEN 'septembre' THEN '09'
                WHEN 'octobre'   THEN '10'
                WHEN 'novembre'  THEN '11'
                WHEN 'décembre'  THEN '12'
            END || '-' ||
            SPLIT_PART(date_installation, ' ', 2),
            'DD-MM-YYYY'
        )
END
```

#### Supprimer le doublon inventaire

```sql
-- Identifier les doublons (même lieu + type)
WITH ranked AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY LOWER(TRIM(lieu)), LOWER(TRIM(type))
               ORDER BY ctid
           ) AS rn
    FROM staging.inventaire_mobilier
)
DELETE FROM staging.inventaire_mobilier
WHERE ctid IN (SELECT ctid FROM ranked WHERE rn > 1);
```

---

### 5.2 signalements

#### Normaliser le statut

```sql
CASE
    WHEN LOWER(TRIM(statut)) = 'fait'        THEN 'fait'
    WHEN LOWER(TRIM(statut)) = 'en attente'  THEN 'en attente'
    WHEN LOWER(TRIM(statut)) = 'en cours'    THEN 'en cours'
    WHEN statut IS NULL OR TRIM(statut) = '' THEN 'en attente'
    ELSE LOWER(TRIM(statut))
END AS statut_norm
```

#### Normaliser l'urgence

```sql
CASE
    WHEN LOWER(TRIM(urgence)) = 'urgent' THEN 'urgent'
    WHEN LOWER(TRIM(urgence)) = 'normal' THEN 'normal'
    WHEN urgence IS NULL OR TRIM(urgence) = '' THEN 'normal'
    ELSE 'normal'
END AS urgence_norm
```

#### Parser les dates signalements (mêmes 4 formats)

Reprendre le même CASE que pour inventaire (voir section 5.1).

#### Supprimer les doublons signalements

Les doublons sont des signalements pour le même objet à 1 jour d'écart :

```sql
WITH ranked AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY LOWER(TRIM(objet)), description
               ORDER BY ctid
           ) AS rn
    FROM staging.signalements
)
DELETE FROM staging.signalements
WHERE ctid IN (SELECT ctid FROM ranked WHERE rn > 1);
```

---

### 5.3 interventions

#### Normaliser les coûts

```sql
CASE
    WHEN LOWER(TRIM(cout_materiel)) IN ('gratuit', 'garantie', '0') THEN 0
    WHEN TRIM(cout_materiel) = '' OR cout_materiel IS NULL            THEN NULL
    ELSE CAST(
        REGEXP_REPLACE(cout_materiel, '[^0-9]', '', 'g')
        AS INTEGER
    )
END AS cout_chf
```

> `REGEXP_REPLACE(val, '[^0-9]', '', 'g')` supprime tout ce qui n'est pas un chiffre.
> Permet de gérer : `CHF 120.-`, `120.-`, `120`.

#### Convertir les durées en minutes

```sql
CASE
    WHEN duree = '30 min'       THEN 30
    WHEN duree = '1h'           THEN 60
    WHEN duree = '1h30'         THEN 90
    WHEN duree = '2h'           THEN 120
    WHEN duree = '3h'           THEN 180
    WHEN duree = 'une matinée'  THEN 240
    WHEN duree = 'une journée'  THEN 480
    ELSE NULL
END AS duree_minutes
```

#### Normaliser les techniciens

Les variantes correspondent à 3 personnes :

| Brut | Normalisé |
|------|-----------|
| Jean-Marc, JM, Jean-Marc Bonvin | Jean-Marc Bonvin |
| Alves Pedro, P. Alves, Pedro | Pedro Alves |
| Koffi Marc | Koffi Marc |
| stagiaire | NULL |

```sql
CASE
    WHEN technicien IN ('Jean-Marc', 'JM', 'Jean-Marc Bonvin') THEN 'Jean-Marc Bonvin'
    WHEN technicien IN ('Alves Pedro', 'P. Alves', 'Pedro')    THEN 'Pedro Alves'
    WHEN technicien = 'Koffi Marc'                             THEN 'Koffi Marc'
    WHEN technicien = 'stagiaire'                              THEN NULL
    ELSE technicien
END AS technicien_norm
```

#### Normaliser le type d'intervention

```sql
CASE
    WHEN LOWER(TRIM(type_intervention)) LIKE 'réparation%'
      OR LOWER(TRIM(type_intervention)) = 'réparation électrique' THEN 'réparation'
    ELSE LOWER(TRIM(type_intervention))
END AS type_intervention_norm
```

---

### 5.4 fournisseurs

#### Normaliser les numéros de téléphone

Les formats présents : `024 423 12 34`, `+41 21 456 78 90`, `0791234567`

```sql
REGEXP_REPLACE(REGEXP_REPLACE(telephone, '\s', '', 'g'), '^(\+41|0041)', '0') AS tel_norm
```

> Supprime les espaces, remplace `+41` ou `0041` par `0`.

#### Détecter les contacts manquants

```sql
SELECT entreprise, contact FROM staging.fournisseurs
WHERE contact IS NULL OR TRIM(contact) = '' OR contact = 'voir site web';
```

---

## Étape 6 - Charger les tables de production

Les tables `mobilier`, `technicien`, `signalement`, `intervention`, `fournisseur` doivent déjà exister dans le schéma `public` (créées lors du module 02).

### technicien (d'abord, car référencé par intervention)

```sql
INSERT INTO public.technicien (nom)
SELECT DISTINCT
    CASE
        WHEN technicien IN ('Jean-Marc', 'JM', 'Jean-Marc Bonvin') THEN 'Jean-Marc Bonvin'
        WHEN technicien IN ('Alves Pedro', 'P. Alves', 'Pedro')    THEN 'Pedro Alves'
        WHEN technicien = 'Koffi Marc'                             THEN 'Koffi Marc'
        ELSE NULL
    END
FROM staging.interventions
WHERE technicien NOT IN ('stagiaire')
  AND technicien IS NOT NULL
ON CONFLICT (nom) DO NOTHING;
```

### fournisseur

```sql
INSERT INTO public.fournisseur (entreprise, contact, telephone, email, type_materiel, remarques)
SELECT
    TRIM(entreprise),
    NULLIF(TRIM(contact), ''),
    NULLIF(REGEXP_REPLACE(REGEXP_REPLACE(telephone, '\s', '', 'g'), '^(\+41|0041)', '0'), ''),
    NULLIF(TRIM(email), ''),
    TRIM(type_materiel),
    NULLIF(TRIM(remarques), '')
FROM staging.fournisseurs
ON CONFLICT DO NOTHING;
```

### mobilier

```sql
INSERT INTO public.mobilier (id_origine, type, materiau, lieu, latitude, longitude,
                              date_installation, etat, remarques)
SELECT
    TRIM(id),
    CASE
        WHEN LOWER(TRIM(type)) LIKE 'banc%'        THEN 'banc'
        WHEN LOWER(TRIM(type)) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(type)) LIKE 'poubelle%'
          OR LOWER(TRIM(type)) = 'corbeille'       THEN 'poubelle'
        WHEN LOWER(TRIM(type)) LIKE 'fontaine%'    THEN 'fontaine'
        WHEN LOWER(TRIM(type)) LIKE '%borne%'      THEN 'borne'
        WHEN LOWER(TRIM(type)) LIKE '%panneau%'    THEN 'panneau'
        ELSE LOWER(TRIM(type))
    END,
    CASE
        WHEN LOWER(TRIM(materiau)) IN ('métal', 'metal') THEN 'métal'
        WHEN LOWER(TRIM(materiau)) = 'pierre'             THEN 'pierre'
        WHEN materiau IS NULL OR TRIM(materiau) = ''      THEN NULL
        ELSE LOWER(TRIM(materiau))
    END,
    TRIM(lieu),
    NULLIF(latitude, '')::NUMERIC,
    NULLIF(longitude, '')::NUMERIC,
    CASE
        WHEN date_installation ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(date_installation, 'DD.MM.YYYY')
        WHEN date_installation ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(date_installation, 'YYYY-MM-DD')
        WHEN date_installation ~ '^\d{4}$'
            THEN TO_DATE(date_installation || '-01-01', 'YYYY-MM-DD')
        ELSE NULL
    END,
    CASE
        WHEN LOWER(TRIM(etat)) IN ('bon', 'bonne')  THEN 'bon'
        WHEN LOWER(TRIM(etat)) LIKE 'usé%'          THEN 'usé'
        WHEN LOWER(TRIM(etat)) LIKE 'à remplacer%'  THEN 'à remplacer'
        ELSE LOWER(TRIM(etat))
    END,
    NULLIF(TRIM(remarques), '')
FROM (
    -- Dédoublonnage : garder la première occurrence par (lieu, type)
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY LOWER(TRIM(lieu)), LOWER(TRIM(type))
            ORDER BY ctid
        ) AS rn
    FROM staging.inventaire_mobilier
) t
WHERE rn = 1
ON CONFLICT DO NOTHING;
```

### signalement

> Note : la colonne `objet` est du texte libre dans les données source. Elle ne peut pas être directement liée à un `mobilier_id`. Ce sera une limite documentée.

```sql
INSERT INTO public.signalement (date_signalement, signale_par, objet, description,
                                 urgence, statut)
SELECT DISTINCT ON (objet, description)
    CASE
        WHEN date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(date, 'DD.MM.YYYY')
        WHEN date ~ '^\d{4}-\d{2}-\d{2}$'   THEN TO_DATE(date, 'YYYY-MM-DD')
        ELSE NULL
    END,
    NULLIF(TRIM(signale_par), ''),
    TRIM(objet),
    TRIM(description),
    CASE
        WHEN LOWER(TRIM(urgence)) = 'urgent' THEN 'urgent'
        ELSE 'normal'
    END,
    CASE
        WHEN LOWER(TRIM(statut)) = 'fait'       THEN 'fait'
        WHEN LOWER(TRIM(statut)) = 'en cours'   THEN 'en cours'
        ELSE 'en attente'
    END
FROM staging.signalements
ORDER BY objet, description, date
ON CONFLICT DO NOTHING;
```

### intervention

```sql
INSERT INTO public.intervention (date_intervention, objet, type_intervention,
                                  technicien_id, duree_minutes, cout_chf, remarques)
SELECT
    CASE
        WHEN date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(date, 'DD.MM.YYYY')
        WHEN date ~ '^\d{4}-\d{2}-\d{2}$'   THEN TO_DATE(date, 'YYYY-MM-DD')
        ELSE NULL
    END,
    TRIM(objet),
    LOWER(TRIM(type_intervention)),
    t.id,
    CASE
        WHEN duree = '30 min'      THEN 30
        WHEN duree = '1h'          THEN 60
        WHEN duree = '1h30'        THEN 90
        WHEN duree = '2h'          THEN 120
        WHEN duree = '3h'          THEN 180
        WHEN duree = 'une matinée' THEN 240
        WHEN duree = 'une journée' THEN 480
        ELSE NULL
    END,
    CASE
        WHEN LOWER(TRIM(cout_materiel)) IN ('gratuit', 'garantie', '0') THEN 0
        WHEN TRIM(cout_materiel) = '' OR cout_materiel IS NULL           THEN NULL
        ELSE CAST(REGEXP_REPLACE(cout_materiel, '[^0-9]', '', 'g') AS INTEGER)
    END,
    NULLIF(TRIM(remarques), '')
FROM staging.interventions i
LEFT JOIN public.technicien t ON t.nom = CASE
    WHEN i.technicien IN ('Jean-Marc', 'JM', 'Jean-Marc Bonvin') THEN 'Jean-Marc Bonvin'
    WHEN i.technicien IN ('Alves Pedro', 'P. Alves', 'Pedro')    THEN 'Pedro Alves'
    WHEN i.technicien = 'Koffi Marc'                             THEN 'Koffi Marc'
    ELSE NULL
END
ON CONFLICT DO NOTHING;
```

---

## Étape 7 - Vérifications finales

```sql
-- Compter les lignes par table
SELECT 'mobilier'     AS table_name, COUNT(*) FROM public.mobilier
UNION ALL
SELECT 'signalement',                  COUNT(*) FROM public.signalement
UNION ALL
SELECT 'intervention',                 COUNT(*) FROM public.intervention
UNION ALL
SELECT 'technicien',                   COUNT(*) FROM public.technicien
UNION ALL
SELECT 'fournisseur',                  COUNT(*) FROM public.fournisseur;

-- Vérifier les NULL sur les champs critiques
SELECT COUNT(*) AS mobilier_sans_type
FROM public.mobilier WHERE type IS NULL;

SELECT COUNT(*) AS interventions_sans_date
FROM public.intervention WHERE date_intervention IS NULL;

SELECT COUNT(*) AS interventions_sans_cout
FROM public.intervention WHERE cout_chf IS NULL;

-- Vérifier la cohérence des types mobilier
SELECT type, COUNT(*) FROM public.mobilier GROUP BY type ORDER BY 2 DESC;
```

---

## Problèmes connus et limites

| Problème | Impact | Décision suggérée |
|----------|--------|-------------------|
| `objet` en texte libre dans signalements et interventions | Impossible de joindre automatiquement à `mobilier` | Documenter la limite ; jointure textuelle approximative possible avec `LIKE` |
| GPS arrondis (~20%) | Localisation imprécise | Conserver, noter la précision réduite |
| GPS manquants (~8%) | Pas de cartographie pour ces objets | NULL accepté |
| Dates format "mars 2022" | Précision : 1er du mois seulement | Acceptable pour les analyses |
| `stagiaire` sans nom | Technicien inconnu | Stocker NULL dans technicien_id |
| `cout = ""` (~8%) | Coût manquant | NULL |
