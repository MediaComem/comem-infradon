-- Infrastructure de Données · TP du cours 04
-- Simule une journée de travail après la sauvegarde du matin,
-- puis une erreur de manipulation à 16 h.
-- À lancer seulement après avoir fait la sauvegarde de l'exercice 4.

-- 9 h - 15 h : le travail continue.
INSERT INTO signalement (mobilier_id, cree_le, description, statut)
SELECT 1 + i % 120, now() - (i || ' minutes')::interval, 'Signalé ce jour', 'ouvert'
FROM generate_series(1, 25) AS i;

INSERT INTO intervention (mobilier_id, technicien_id, date_intervention, cout)
SELECT 1 + i % 120, 1 + i % 3, current_date, 50
FROM generate_series(1, 12) AS i;

-- 16 h : nettoyage des interventions de test.
-- La personne a oublié le WHERE.
DELETE FROM intervention;
