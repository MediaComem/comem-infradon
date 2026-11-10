-- Infrastructure de Données · TP du cours 04
-- Base fictive du Service technique, avec des rôles créés au fil des années
-- et jamais revus. Toutes les personnes sont inventées.
-- Le script peut être relancé : il repart de tables et de rôles vides.

SET client_min_messages = warning;

DROP TABLE IF EXISTS intervention, signalement, technicien, mobilier CASCADE;
DROP VIEW IF EXISTS signalement_actif;

DO $$
DECLARE
  r text;
BEGIN
  FOREACH r IN ARRAY ARRAY['app_web', 'm_dupont', 'lecture_seule',
    'service_technique', 'alice', 'bob', 'carla',
    'citoyen', 'technicien', 'responsable']
  LOOP
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = r) THEN
      EXECUTE format('DROP OWNED BY %I', r);
      EXECUTE format('DROP ROLE %I', r);
    END IF;
  END LOOP;
END
$$;

DO $$ BEGIN PERFORM setseed(0.4); END $$;

CREATE TABLE mobilier (
  id   int PRIMARY KEY,
  type text NOT NULL,
  lieu text NOT NULL
);

INSERT INTO mobilier
SELECT i,
       (ARRAY['banc', 'lampadaire', 'fontaine', 'poubelle', 'borne'])[1 + i % 5],
       (ARRAY['Place Pestalozzi', 'Rue du Lac', 'Avenue de la Gare',
              'Parc des Rives', 'Rue du Casino', 'Y-Parc'])[1 + i % 6]
FROM generate_series(1, 120) AS i;

CREATE TABLE technicien (
  id        int PRIMARY KEY,
  nom       text NOT NULL,
  email     text,
  telephone text
);

INSERT INTO technicien VALUES
  (1, 'Jean-Marc Bonvin', 'jm.bonvin@service.test', '079 200 11 01'),
  (2, 'Pedro Alves',      'p.alves@service.test',   '079 200 11 02'),
  (3, 'Marc Koffi',       'm.koffi@service.test',   '079 200 11 03'),
  (4, 'Marie Dupont',     'm.dupont@service.test',  '079 200 11 04');

CREATE TABLE signalement (
  id          int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  mobilier_id int NOT NULL REFERENCES mobilier,
  cree_le     timestamp NOT NULL,
  description text NOT NULL,
  statut      text NOT NULL CHECK (statut IN ('ouvert', 'résolu'))
);

INSERT INTO signalement (mobilier_id, cree_le, description, statut)
SELECT 1 + floor(random() * 120)::int,
       timestamp '2022-01-01' + random() * interval '1400 days',
       (ARRAY['Lampadaire éteint', 'Banc cassé', 'Poubelle pleine',
              'Fontaine qui fuit', 'Tag', 'Borne en panne'])[1 + floor(random() * 6)::int],
       CASE WHEN random() < 0.85 THEN 'résolu' ELSE 'ouvert' END
FROM generate_series(1, 2000);

CREATE TABLE intervention (
  id                int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  mobilier_id       int NOT NULL REFERENCES mobilier,
  technicien_id     int NOT NULL REFERENCES technicien,
  date_intervention date NOT NULL,
  cout              numeric(8, 2) NOT NULL CHECK (cout >= 0)
);

INSERT INTO intervention (mobilier_id, technicien_id, date_intervention, cout)
SELECT 1 + floor(random() * 120)::int,
       1 + floor(random() * 3)::int,
       date '2022-01-01' + floor(random() * 1400)::int,
       round((random() * 400)::numeric, 2)
FROM generate_series(1, 1500);

-- Rôles créés au fil des années.
CREATE ROLE app_web LOGIN SUPERUSER PASSWORD 'app';
COMMENT ON ROLE app_web IS 'Compte de l''application de signalement';

CREATE ROLE m_dupont LOGIN PASSWORD 'dupont';
COMMENT ON ROLE m_dupont IS 'Marie Dupont, technicienne, partie en mars 2024';
GRANT ALL ON ALL TABLES IN SCHEMA public TO m_dupont;

CREATE ROLE service_technique LOGIN PASSWORD 'yverdon2019';
COMMENT ON ROLE service_technique IS 'Compte partagé par les technicien·ne·s';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public
  TO service_technique;

CREATE ROLE lecture_seule LOGIN PASSWORD 'lecture';
COMMENT ON ROLE lecture_seule IS 'Tableau de bord du conseil communal';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecture_seule;
GRANT INSERT ON signalement TO lecture_seule;

GRANT SELECT ON technicien TO PUBLIC;

ANALYZE;
