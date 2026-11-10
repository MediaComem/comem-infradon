-- Infrastructure de Données · TP du cours 02
-- Tables cibles pour l'import de 02-interventions.csv.
-- Les données sont fictives. Le script peut être relancé : il repart de tables vides.

SET client_min_messages = warning;

DROP TABLE IF EXISTS rejet, intervention, journal_import, technicien CASCADE;
DROP SCHEMA IF EXISTS staging CASCADE;

-- Personnel du Service technique.
CREATE TABLE technicien (
  id  int PRIMARY KEY,
  nom text NOT NULL UNIQUE
);

INSERT INTO technicien VALUES
  (1, 'Jean-Marc Bonvin'),
  (2, 'Pedro Alves'),
  (3, 'Marc Koffi');

-- Une ligne par exécution de l'import.
CREATE TABLE journal_import (
  lot_id          int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  fichier         text NOT NULL,
  importe_le      timestamptz NOT NULL DEFAULT now(),
  lignes_lues     int,
  lignes_valides  int,
  lignes_rejetees int
);

-- Table de production : types, contraintes, provenance.
CREATE TABLE intervention (
  id                int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  date_intervention date NOT NULL,
  objet             text NOT NULL,
  type_intervention text NOT NULL,
  technicien_id     int REFERENCES technicien,
  duree_min         int CHECK (duree_min > 0),
  cout_materiel     numeric(8, 2) CHECK (cout_materiel >= 0),
  remarques         text,
  lot_id            int NOT NULL REFERENCES journal_import,
  ligne_source      int NOT NULL
);
