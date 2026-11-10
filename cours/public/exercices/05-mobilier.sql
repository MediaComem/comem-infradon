-- Infrastructure de Données · TP du cours 05
-- Jeu de test volumineux et fictif, généré pour comparer colonnes et JSONB.
-- Les fichiers du Service technique sont trop petits pour que PostgreSQL
-- utilise un index : sur une centaine de lignes, un Seq Scan reste plus rapide.
-- Le script peut être relancé : il repart de tables vides.

DROP MATERIALIZED VIEW IF EXISTS couts_par_type;
DROP TABLE IF EXISTS interventions_test;
DROP TABLE IF EXISTS mobilier_jsonb;
DROP TABLE IF EXISTS mobilier_colonnes;

-- Une colonne par attribut : la plupart restent vides selon le type.
CREATE TABLE mobilier_colonnes AS
SELECT i AS id,
       (ARRAY['lampadaire', 'banc', 'borne'])[1 + i % 3] AS type,
       CASE WHEN i % 3 = 0 THEN 150 END AS puissance_w,
       CASE
         WHEN i % 300 = 0 THEN 'solaire'
         WHEN i % 3 = 0 AND i % 2 = 0 THEN 'LED'
         WHEN i % 3 = 0 THEN 'sodium'
       END AS technologie,
       CASE WHEN i % 3 = 1 THEN 'bois' END AS materiau,
       CASE WHEN i % 3 = 2 THEN 'type 2' END AS prise
FROM generate_series(1, 300000) AS i;

ALTER TABLE mobilier_colonnes ADD PRIMARY KEY (id);

-- Les mêmes objets : colonnes communes, attributs variables en JSONB.
CREATE TABLE mobilier_jsonb AS
SELECT id,
       type,
       jsonb_strip_nulls(jsonb_build_object(
         'puissance_w', puissance_w,
         'technologie', technologie,
         'materiau', materiau,
         'prise', prise
       )) AS attributs
FROM mobilier_colonnes;

ALTER TABLE mobilier_jsonb ADD PRIMARY KEY (id);

-- Un million d'interventions réparties sur tous les objets.
CREATE TABLE interventions_test AS
SELECT i AS id,
       1 + (i % 300000) AS mobilier_id,
       (i % 500)::NUMERIC(8, 2) AS cout
FROM generate_series(1, 1000000) AS i;

ALTER TABLE interventions_test ADD PRIMARY KEY (id);

ANALYZE mobilier_colonnes;
ANALYZE mobilier_jsonb;
ANALYZE interventions_test;
