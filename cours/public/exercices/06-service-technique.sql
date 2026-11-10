-- Infrastructure de Données · TP du cours 06
-- Base fictive du Service technique d'Yverdon-les-Bains, pour un audit
-- de conformité, de qualité et de biais.
-- Toutes les personnes, adresses et chiffres sont inventés.
-- Le script peut être relancé : il repart de tables vides.

SET client_min_messages = warning;

DROP TABLE IF EXISTS registre_traitements, inspection, position_gps,
  signalement, technicien, quartier CASCADE;

DO $$
BEGIN
  IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'stagiaire') THEN
    DROP OWNED BY stagiaire;
    DROP ROLE stagiaire;
  END IF;
  IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'portail_public') THEN
    DROP OWNED BY portail_public;
    DROP ROLE portail_public;
  END IF;
END
$$;

DO $$ BEGIN PERFORM setseed(0.42); END $$;

-- Quartiers et population.
CREATE TABLE quartier (
  id        int PRIMARY KEY,
  nom       text NOT NULL,
  habitants int NOT NULL
);

INSERT INTO quartier VALUES
  (1, 'Centre',           4200),
  (2, 'Gare-Lac',         3100),
  (3, 'Pierre-de-Savoie', 3800),
  (4, 'Les Moulins',      2900),
  (5, 'Clendy',           3500),
  (6, 'Floreyres',        2600),
  (7, 'Bel-Air',          3300),
  (8, 'Villette',         2400);

-- Personnel du Service technique, y compris deux personnes parties.
CREATE TABLE technicien (
  id             int PRIMARY KEY,
  nom            text NOT NULL,
  prenom         text NOT NULL,
  email          text,
  telephone      text,
  date_naissance date,
  engage_le      date NOT NULL,
  parti_le       date
);

INSERT INTO technicien VALUES
  (1, 'Rochat',   'Léa',     'lea.rochat@service.test',     '079 100 11 01', '1984-03-12', '2019-01-07', NULL),
  (2, 'Bovet',    'Samuel',  'samuel.bovet@service.test',   '079 100 11 02', '1991-07-30', '2019-01-07', NULL),
  (3, 'Nguyen',   'Linh',    'linh.nguyen@service.test',    '079 100 11 03', '1979-11-02', '2019-01-07', '2020-06-30'),
  (4, 'Pereira',  'Ana',     'ana.pereira@service.test',    '079 100 11 04', '1995-01-18', '2020-08-03', NULL),
  (5, 'Jaquier',  'Marc',    'marc.jaquier@service.test',   '079 100 11 05', '1968-05-25', '2019-01-07', '2022-12-31'),
  (6, 'Haddad',   'Yasmine', 'yasmine.haddad@service.test', '079 100 11 06', '1988-09-09', '2023-02-01', NULL);

-- Position de chaque véhicule toutes les 5 minutes, jamais purgée.
CREATE TABLE position_gps AS
SELECT t.id AS technicien_id,
       j + interval '7 hours' + k * interval '5 minutes' AS horodatage,
       round((46.770 + random() * 0.020)::numeric, 5) AS lat,
       round((6.625 + random() * 0.030)::numeric, 5) AS lon
FROM technicien AS t
CROSS JOIN generate_series(timestamp '2019-01-07', timestamp '2026-10-30', interval '1 day') AS j
CROSS JOIN generate_series(0, 107) AS k
WHERE extract(isodow FROM j) < 6
  AND j >= t.engage_le
  AND j <= coalesce(t.parti_le, date '2026-10-30');

ALTER TABLE position_gps ADD FOREIGN KEY (technicien_id) REFERENCES technicien;

-- Signalements de la population depuis 2018.
CREATE TABLE signalement (
  id               serial PRIMARY KEY,
  cree_le          timestamp NOT NULL,
  quartier_id      int REFERENCES quartier,
  canal            text NOT NULL,
  nom_auteur       text,
  email_auteur     text,
  telephone_auteur text,
  description      text,
  urgence          int,
  statut           text,
  traite_le        timestamp
);

-- taux : signalements par an pour 1000 habitants.
-- part_app : part des signalements passés par l'application.
WITH profil (quartier_id, taux, part_app) AS (
  VALUES (1, 26, 0.70), (2, 24, 0.65), (3, 25, 0.60), (4, 7, 0.10),
         (5, 23, 0.60), (6, 24, 0.65), (7, 22, 0.55), (8, 25, 0.70)
),
tirage AS (
  SELECT p.quartier_id,
         timestamp '2018-03-01'
           + random() * (timestamp '2026-10-31' - timestamp '2018-03-01') AS cree_le,
         CASE
           WHEN random() < p.part_app THEN 'app'
           WHEN random() < 0.8 THEN 'téléphone'
           ELSE 'guichet'
         END AS canal,
         (ARRAY['Julie', 'Thomas', 'Fatima', 'Luca', 'Sophie', 'Kevin',
                'Mélanie', 'Arben', 'Claire', 'Nicolas', 'Inès', 'Pierre'])
           [1 + floor(random() * 12)::int] AS prenom,
         (ARRAY['Favre', 'Berisha', 'Martin', 'Silva', 'Muller', 'Chevalley',
                'Dubois', 'Rossi', 'Perret', 'Ramadani', 'Gonin', 'Blanc'])
           [1 + floor(random() * 12)::int] AS nom,
         random() AS r_mail, random() AS r_tel, random() AS r_urg,
         random() AS r_stat, random() AS r_delai, random() AS r_desc
  FROM profil AS p
  JOIN quartier AS q ON q.id = p.quartier_id
  CROSS JOIN LATERAL generate_series(1, (q.habitants * p.taux * 8.7 / 1000)::int)
)
INSERT INTO signalement (cree_le, quartier_id, canal, nom_auteur, email_auteur,
                         telephone_auteur, description, urgence, statut, traite_le)
SELECT cree_le,
       quartier_id,
       canal,
       prenom || ' ' || nom,
       CASE
         WHEN canal <> 'app' THEN NULL
         WHEN r_mail < 0.03 THEN lower(nom) || '.mail.test'
         ELSE lower(prenom || '.' || nom) || '@mail.test'
       END,
       CASE
         WHEN canal <> 'app' OR r_tel < 0.3
         THEN '07' || (6 + floor(r_tel * 4))::int || ' 2'
              || lpad(floor(r_tel * 1000000)::int::text, 6, '0')
       END,
       CASE
         WHEN r_desc < 0.004 THEN 'Banc cassé sur mon trajet, je suis en fauteuil roulant et je ne peux plus passer'
         WHEN r_desc < 0.008 THEN 'Lampadaire éteint, ma fille est malvoyante et elle est tombée hier soir'
         WHEN r_desc < 0.012 THEN 'Une personne sans abri dort sous l''abri bus depuis une semaine'
         WHEN r_desc < 0.016 THEN 'Je suis à l''AI et je dois passer ici chaque jour pour mon traitement, le trottoir est dangereux'
         ELSE (ARRAY['Lampadaire éteint', 'Banc cassé', 'Poubelle pleine',
                     'Fontaine qui fuit', 'Borne de recharge en panne',
                     'Tag sur le banc', 'Lampadaire qui clignote',
                     'Planche du banc arrachée'])[1 + floor(r_desc * 8)::int]
       END,
       CASE
         WHEN r_urg < 0.04 THEN NULL
         WHEN r_urg < 0.05 THEN 5
         ELSE 1 + floor((r_urg - 0.05) / 0.95 * 3)::int
       END,
       CASE
         WHEN cree_le < timestamp '2026-09-01' AND r_stat < 0.88 THEN 'résolu'
         ELSE 'ouvert'
       END,
       CASE
         WHEN cree_le >= timestamp '2026-09-01' OR r_stat >= 0.88 THEN NULL
         WHEN r_delai < 0.03 THEN NULL
         WHEN r_delai < 0.04 THEN cree_le - interval '2 days'
         ELSE cree_le + (1 + r_delai * 30) * interval '1 day'
       END
FROM tirage
ORDER BY cree_le;

-- Une partie des signalements de l'application a été importée deux fois.
INSERT INTO signalement (cree_le, quartier_id, canal, nom_auteur, email_auteur,
                         telephone_auteur, description, urgence, statut, traite_le)
SELECT cree_le, quartier_id, canal, nom_auteur, email_auteur,
       telephone_auteur, description, urgence, statut, traite_le
FROM signalement
WHERE canal = 'app' AND id % 60 = 0;

-- Inspection systématique de septembre 2026, faite par des patrouilles.
CREATE TABLE inspection (
  quartier_id  int PRIMARY KEY REFERENCES quartier,
  inspecte_le  date NOT NULL,
  objets       int NOT NULL,
  defectueux   int NOT NULL
);

INSERT INTO inspection VALUES
  (1, '2026-09-07', 180, 15),
  (2, '2026-09-08', 120, 10),
  (3, '2026-09-09', 150, 13),
  (4, '2026-09-10', 130, 32),
  (5, '2026-09-14', 140, 12),
  (6, '2026-09-15', 110,  9),
  (7, '2026-09-16', 135, 12),
  (8, '2026-09-17',  95,  8);

-- Registre des activités de traitement, à remplir pendant le TP.
CREATE TABLE registre_traitements (
  traitement           text PRIMARY KEY,
  finalite             text NOT NULL,
  personnes_concernees text NOT NULL,
  donnees              text NOT NULL,
  destinataires        text,
  duree_conservation   text,
  localisation         text
);

-- Rôles créés il y a quelques années, jamais revus.
CREATE ROLE stagiaire LOGIN PASSWORD 'stagiaire';
GRANT SELECT ON quartier, technicien, position_gps, signalement, inspection
  TO stagiaire;

CREATE ROLE portail_public LOGIN PASSWORD 'portail';
GRANT SELECT ON quartier, signalement TO portail_public;

ANALYZE;
