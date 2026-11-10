-- Infrastructure de Données · TP du cours 03
-- 10 000 comptes fictifs à 1000 francs chacun, pour les mesures avec pgbench.
-- Le script peut être relancé : il repart d'une table neuve.
-- Invariant : la somme des soldes vaut toujours 10 000 000.

DROP TABLE IF EXISTS compte;

CREATE TABLE compte (
  id        INTEGER PRIMARY KEY,
  titulaire VARCHAR(50),
  solde     NUMERIC
);

INSERT INTO compte
SELECT i, 'titulaire ' || i, 1000
FROM generate_series(1, 10000) AS i;

ANALYZE compte;
