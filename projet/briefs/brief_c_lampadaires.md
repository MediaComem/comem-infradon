# Brief C — Plan de remplacement des lampadaires

## Contexte

La Commune dispose d'un crédit de CHF 50'000.- pour remplacer des lampadaires en 2026. Le responsable des infrastructures vous demande de prioriser les remplacements.

## Demande

### Livrable 1 — Fiche de chaque lampadaire

Produire une vue SQL qui affiche pour chaque lampadaire :

- L'identifiant et le lieu
- Le type (sodium / LED)
- L'année d'installation
- Le nombre de pannes (interventions)
- Le coût cumulé des interventions
- La date de la dernière intervention
- Les coordonnées GPS

### Livrable 2 — Classement de priorité

Produire une vue SQL qui attribue un score de priorité à chaque lampadaire, calculé comme suit :

- Nombre de pannes × 3
- \+ âge en années × 2
- \+ coût cumulé / 100

Afficher les lampadaires triés par score décroissant.

### Livrable 3 — Sélection dans le budget

Produire une vue SQL qui sélectionne les lampadaires à remplacer par ordre de priorité, en s'arrêtant quand le coût cumulé estimé de remplacement dépasse CHF 50'000.-. Utiliser le coût moyen d'une intervention de type "remplacement complet" comme estimation du coût de remplacement.

Inclure les coordonnées GPS pour cartographie.

## Format de rendu

- 3 vues SQL nommées `v_lampadaires_detail`, `v_lampadaires_priorite`, `v_lampadaires_budget`
- Un court paragraphe (5-10 lignes) justifiant le classement
