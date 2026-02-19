# Brief A — Rapport budgétaire pour le Conseil communal

## Contexte

Le Conseil communal d'Yverdon-les-Bains prépare le budget 2027. La cheffe du Service technique vous demande un rapport chiffré sur les coûts d'entretien du mobilier urbain.

## Demande

### Livrable 1 — Coût par type de mobilier

Produire une vue SQL qui affiche, pour 2024 et 2025 séparément :

- Le type de mobilier (normalisé)
- Le nombre d'interventions
- Le coût total
- Le coût moyen par intervention

### Livrable 2 — Top 5 des objets les plus coûteux

Produire une vue SQL qui affiche les 5 objets avec le coût cumulé le plus élevé (toutes années confondues), incluant :

- Le type et le lieu
- Le nombre total d'interventions
- Le coût cumulé
- Les coordonnées GPS (latitude, longitude)

### Livrable 3 — Saisonnalité

Produire une vue SQL qui affiche le nombre d'interventions et le coût total par mois (agrégé sur toutes les années), pour identifier les pics saisonniers.

## Format de rendu

- 3 vues SQL nommées `v_budget_par_type`, `v_top5_couteux`, `v_saisonnalite`
- Un court paragraphe (5-10 lignes) interprétant les résultats
