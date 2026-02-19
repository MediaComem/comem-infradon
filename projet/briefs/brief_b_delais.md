# Brief B — Analyse des délais de traitement par quartier

## Contexte

Les habitants du quartier de la Gare se plaignent que les signalements de mobilier défectueux mettent trop longtemps à être traités. La municipale demande des chiffres.

## Demande

### Livrable 1 — Délai moyen par quartier

Produire une vue SQL qui affiche, pour chaque quartier d'Yverdon :

- Le nombre de signalements
- Le nombre d'interventions associées
- Le délai moyen (en jours) entre le signalement et l'intervention
- Le délai médian

Le quartier doit être déterminé à partir des coordonnées GPS ou du lieu du mobilier.

### Livrable 2 — Signalements ouverts depuis plus de 30 jours

Produire une vue SQL qui liste les signalements avec statut "en attente" ou "en cours" dont la date remonte à plus de 30 jours, incluant :

- La date du signalement
- L'objet concerné
- La description
- Les coordonnées GPS (si disponibles)

### Livrable 3 — Taux de résolution par trimestre

Produire une vue SQL qui affiche par trimestre (Q1 2023, Q2 2023, etc.) :

- Le nombre total de signalements
- Le nombre de signalements résolus (statut = "fait")
- Le taux de résolution (en %)

## Format de rendu

- 3 vues SQL nommées `v_delai_par_quartier`, `v_signalements_ouverts`, `v_taux_resolution`
- Un court paragraphe (5-10 lignes) interprétant les résultats
