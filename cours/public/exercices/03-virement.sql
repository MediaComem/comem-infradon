-- Script pgbench : un virement de 10 francs entre deux comptes distincts.
-- :nb est le nombre de comptes tirés au sort, passé avec -D nb=...
-- Les deux comptes sont mis à jour dans l'ordre du virement : débit, puis crédit.
\set de random(1, :nb)
\set vers 1 + (:de + random(0, :nb - 2)) % :nb
BEGIN;
SELECT solde FROM compte WHERE id = :de;
UPDATE compte SET solde = solde - 10 WHERE id = :de;
UPDATE compte SET solde = solde + 10 WHERE id = :vers;
COMMIT;
