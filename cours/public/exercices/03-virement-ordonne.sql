-- Script pgbench : le même virement, mais les comptes sont toujours
-- verrouillés dans le même ordre : le plus petit id d'abord.
\set de random(1, :nb)
\set vers 1 + (:de + random(0, :nb - 2)) % :nb
\set premier least(:de, :vers)
\set second greatest(:de, :vers)
BEGIN;
SELECT solde FROM compte WHERE id = :de;
UPDATE compte SET solde = solde + CASE WHEN id = :de THEN -10 ELSE 10 END
WHERE id = :premier;
UPDATE compte SET solde = solde + CASE WHEN id = :de THEN -10 ELSE 10 END
WHERE id = :second;
COMMIT;
