# Brief D — Renouvellement du parc de bancs

## Contexte

Le fournisseur principal de bancs (Mobilier Urbain Suisse SA) a fermé en mars 2025. Avant de chercher un nouveau fournisseur, le Service technique a besoin d'un état des lieux complet.

## Demande

### Livrable 1 — État du parc actuel

Produire une vue SQL qui affiche :

- Le nombre total de bancs
- La répartition par matériau (bois / métal)
- L'âge moyen par matériau
- La répartition par état (bon / usé / à remplacer)
- Le nombre de bancs sans coordonnées GPS

### Livrable 2 — Bancs à remplacer dans les 2 ans

Produire une vue SQL qui identifie les bancs nécessitant un remplacement, définis comme :

- État = "usé" ou "à remplacer"
- OU plus de 3 interventions enregistrées

Afficher pour chaque banc : le lieu, le matériau, l'âge, le nombre d'interventions, l'état, et les coordonnées GPS.

### Livrable 3 — Estimation budgétaire

Produire une vue SQL qui calcule :

- Le nombre de bancs à remplacer (depuis le livrable 2)
- Le coût moyen d'un remplacement (basé sur les interventions de type "remplacement" dans l'historique)
- Le budget total estimé
- La répartition du budget : bancs bois vs bancs métal

## Format de rendu

- 3 vues SQL nommées `v_parc_bancs`, `v_bancs_a_remplacer`, `v_budget_bancs`
- Un court paragraphe (5-10 lignes) avec une recommandation (bois ou métal pour les remplacements ?)
