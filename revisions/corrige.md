# Corrigé - Examen type InfraDon (Festival)

---

## Partie 1 | QCM

| Q | Réponse | Justification |
|---|---------|---------------|
| Q1 | **D - Atomicité** | Tout ou rien : débit + création du billet forment une unité indivisible |
| Q2 | **B - Lost update** | Deux transactions lisent la même capacité, chacune pense avoir la dernière place, toutes deux insèrent |
| Q3 | **C - Hash** | Recherche par égalité exacte sur une valeur unique : Hash est O(1) vs B-Tree O(log n) |
| Q4 | **B - 487 312 lignes lues et rejetées** | Un index sur `statut` permettrait d'éviter ce scan complet |
| Q5 | **C - GRANT SELECT puis GRANT UPDATE (statut)** | Seule option qui accorde UPDATE au niveau colonne, évitant l'accès aux données de paiement |
| Q6 | **B - ELT** | On charge les données brutes en base, puis on transforme dans PostgreSQL |
| Q7 | **B - Clé-valeur (Redis)** | Accès O(1) par clé (code_barre -> statut), latence sous la milliseconde |
| Q8 | **C - `NULLIF(TRIM(statut), '')`** | `TRIM` supprime les espaces, puis `NULLIF(..., '')` convertit la chaîne vide résultante en `NULL` — les deux cas indésirables retournent donc `NULL` |
| Q9 | **C - Graphe (Neo4j)** | Les relations entre participant·e·s et concerts ("a aussi aimé") sont naturellement un graphe |
| Q10 | **B - Oui, dès lors que des personnes physiques sont concernées** | La nLPD s'applique à toute entité traitant des données personnelles de personnes physiques en Suisse |

---

## Partie 2 | SQL

### 2.1 | Import et nettoyage

| Q | Réponse | Justification |
|---|---------|---------------|
| Q1 | **Faux** | Tous les champs sont `TEXT` : `'CHF 45.-'` est accepté sans erreur dans la staging |
| Q2 | **Vrai** | `'early bird'` ne correspond à aucun `WHEN` -> `ELSE NULL` |
| Q3 | **Vrai** | `REGEXP_REPLACE` supprime tout sauf les chiffres et le point, `'CHF 45.-'` devient `'45.'` -> `45` en NUMERIC |
| Q4 | **Faux** | Les JOIN sont des INNER JOIN : si `participant` ou `concert` n'est pas trouvé, la ligne est exclue de l'INSERT |
| Q5 | **Vrai** | `NULLIF(TRIM(NULL), '')` retourne `NULL`, et `NULL IS NOT NULL` est faux : la ligne est exclue par la clause `WHERE` |

### 2.2 | Transactions et isolation

| Q | Réponse | Justification |
|---|---------|---------------|
| Q6 | **Vrai** | En `READ COMMITTED`, chaque SELECT voit la version commitée au moment de son exécution, donc T2 commitée -> visible |
| Q7 | **Vrai** | Sans mécanisme de vérification de `capacite_max` dans la transaction, l'INSERT s'exécute librement |
| Q8 | **Faux** | `SERIALIZABLE` détecte des dépendances entre transactions et peut annuler l'une d'elles, mais ne vérifie pas automatiquement les règles métier comme `capacite_max`. Il faut toujours une contrainte explicite ou un `SELECT ... FOR UPDATE` |
| Q9 | **Vrai** | `SKIP LOCKED` ignore les lignes déjà verrouillées par une autre transaction : chaque bénévole traite un billet différent en parallèle |

### 2.3 | Rôles et permissions

| Q | Réponse | Justification |
|---|---------|---------------|
| Q10 | **Vrai** | Lea a le rôle `participant_web` qui a `SELECT ON concert` |
| Q11 | **Faux** | Sam a `organisateur` qui a `ALL PRIVILEGES` sur `billet`, `participant` et `vente`, mais aucun privilège n'est accordé sur `concert` |
| Q12 | **Faux** | Lea a le rôle `participant_web` qui n'a que `SELECT` sur `billet`, pas `UPDATE` |
| Q13 | **Vrai** | Sam a `organisateur` qui a `ALL PRIVILEGES ON vente`, ce qui inclut `DELETE` |
| Q14 | **Vrai** | La syntaxe est correcte : `REVOKE SELECT ON billet FROM benevole;` |

### 2.4 | Index et optimisation

| Q | Réponse | Justification |
|---|---------|---------------|
| Q15 | **Vrai** | 498 180 filtrées + 1 820 retournées = 500 000 lignes parcourues (Seq Scan) |
| Q16 | **Vrai** | 95.210 ms / 1.340 ms ≈ 71, soit environ 70x |
| Q17 | **Faux** | L'index `idx_billet_concert` est sur la table `billet` (colonne `concert_id`) ; il ne touche pas la table `participant`. La recherche par email fait toujours un `Seq Scan on participant` car aucun index n'existe sur cette table |
| Q18 | **Faux** | Les index ralentissent les écritures (INSERT, UPDATE, DELETE) car ils doivent être mis à jour à chaque modification |

---

## Partie 3 | Transactions et architectures

### 3.1a - Tableau des niveaux d'isolation

| Niveau | Dirty read | Non-repeatable read | Phantom read |
|---|:---:|:---:|:---:|
| READ COMMITTED | Empêche | N'empêche pas | N'empêche pas |
| REPEATABLE READ | Empêche | Empêche | Empêche (PostgreSQL va plus loin que le standard) |
| SERIALIZABLE | Empêche | Empêche | Empêche |

### 3.1b - Anomalie et correction

Anomalie : **lost update**. T1 et T2 lisent toutes deux le COUNT à 499, chacune pense qu'il reste une place et insère un billet, amenant le total à 501.

Correction : verrouiller la ligne du concert avec `FOR UPDATE` avant de vérifier la capacité. Toute autre transaction qui tente de faire de même attend que la première soit terminée.

```sql
BEGIN;
-- Verrouiller le concert : T2 attendra que T1 commite
SELECT id FROM concert WHERE id = $1 FOR UPDATE;
-- Vérifier la capacité
SELECT COUNT(*) FROM billet
  WHERE concert_id = $1 AND statut != 'annule';
-- Si count < capacite_max, insérer
INSERT INTO billet (concert_id, participant_id, statut, prix)
  VALUES ($1, $2, 'valide', $3);
COMMIT;
```

### 3.2a - Pipeline ELT pour le festival

- **Extract** : extraire les données des sources (fichiers CSV du prestataire billetterie, exports du système de contrôle d'accès, relevés de caisses restauration).
- **Load** : charger les données brutes dans des tables de staging (tout en TEXT, sans contraintes) dans PostgreSQL.
- **Transform** : nettoyer, typer, dédupliquer et agréger : normaliser les types de billets, calculer le chiffre d'affaires par scène et par jour, calculer le taux de remplissage par concert.

### 3.2b - Conflit OLTP / OLAP

Cause : le rapport analytique (OLAP) scanne toute la table `billet` (500 000 lignes) et monopolise les ressources I/O et CPU du serveur PostgreSQL. Cette charge entre en contention avec les petites transactions OLTP de l'achat en ligne, qui doivent lire et écrire des lignes individuelles en moins d'une seconde.

Deux solutions :
1. **Read replica** : une copie de la base en lecture seule, dédiée aux requêtes analytiques. Le rapport tourne sur le replica, sans impacter le nœud principal qui gère les achats.
2. **Séparation OLTP / OLAP** : alimenter un entrepôt de données distinct via un pipeline ELT nocturne. Les rapports tournent sur cet entrepôt, isolé de la base opérationnelle.

### 3.2c - Data mesh

Le concept est le **data mesh**. Deux principes fondamentaux :
1. **Propriété des données par domaine** (domain ownership) : chaque équipe (billetterie, programmation, restauration) est responsable de ses propres données, de leur qualité et de leur exposition.
2. **Données comme produit** (data as a product) : chaque domaine expose ses données sous forme de produits consommables par les autres domaines, avec des contrats de qualité définis.

### 3.3a - Sauvegarde pendant le festival

```bash
pg_dump -U postgres -d festival -F c -f backup_jour1_$(date +%Y%m%d).dump
```

Format custom (`-F c`) recommandé car :
- Compressé automatiquement (gain de place significatif sur 500 000 billets)
- Permet la restauration sélective avec `pg_restore -t billet`
- Permet la restauration parallèle (`-j`)

### 3.3b - Restauration de la table billet uniquement

1. Créer une base temporaire :
   ```bash
   createdb -U postgres festival_restore_tmp
   ```
2. Restaurer uniquement la table `billet` :
   ```bash
   pg_restore -U postgres -d festival_restore_tmp -t billet backup_jour1.dump
   ```
3. Réimporter les données en production :
   ```sql
   INSERT INTO festival.billet SELECT * FROM festival_restore_tmp.billet
   ON CONFLICT (id) DO NOTHING;
   ```

### 3.3c - Soft delete vs hard delete

Avantages du soft delete pour le festival :
- **Traçabilité** : garder un historique de tous les billets annulés pour les réclamations éventuelles.
- **Réversibilité** : possibilité de réactiver un billet annulé par erreur sans restauration.
- **Audit** : statistiques complètes sur les ventes et annulations pour les éditions suivantes.

Tension légale : si un·e participant·e demande la suppression de ses données personnelles, un soft delete ne suffit pas - il faut effectivement supprimer ou anonymiser ses données, y compris dans les billets "soft-deleted".

---

## Partie 4 | Éthique et gouvernance

### 4.1a - Biais algorithmique par boucle de rétroaction

Problème : **boucle de rétroaction** (feedback loop). L'algorithme est entraîné uniquement sur les achats passés. Les genres peu représentés (musiques du monde, jazz) génèrent peu de clics -> l'algorithme les recommande moins -> ils vendent encore moins de billets -> ils disparaissent progressivement de l'offre visible, même s'il existe une demande réelle.

Recommandation :
- Diversifier les sources de données d'entraînement (pas uniquement les historiques d'achat).
- Introduire une contrainte de diversité : s'assurer que chaque genre musical bénéficie d'une visibilité minimale dans les recommandations.
- Auditer régulièrement les résultats de l'algorithme par genre et par artiste.
- Maintenir un contrôle humain sur la programmation finale.

### 4.1b - Hébergement chez un prestataire américain

Problème : **souveraineté numérique et Cloud Act (2018)**. Le Cloud Act permet aux autorités américaines d'accéder aux données détenues par des entreprises américaines (AWS, Google, Microsoft), quelle que soit la localisation physique des serveurs. Le fait que les serveurs soient en Irlande ne protège pas contre les injonctions américaines adressées à AWS.

Recommandation : utiliser un hébergeur européen ou suisse non soumis au Cloud Act (Infomaniak, Exoscale, Scaleway, OVHcloud), ou à défaut signer un accord de traitement des données conforme au RGPD et à la nLPD, et évaluer les risques résiduels.

### 4.1c - Conservation des données 15 ans

Problème : violation du principe de **limitation de la conservation**. Conserver des emails et historiques d'achat 15 ans "au cas où" n'est pas une finalité légitime et définie.

Correction :
- Définir une politique de rétention documentée (ex : données de contact conservées 2 ans après le dernier achat, puis suppression ou anonymisation).
- Automatiser la purge avec un job planifié.
- Proposer aux participant·e·s un opt-in explicite pour être recontacté·e·s pour les éditions suivantes.

### 4.1d - Reconnaissance faciale

Problème : la reconnaissance faciale produit des **données biométriques**, catégorie de données sensibles au sens de la nLPD. Son traitement est soumis à des conditions strictes. Par ailleurs, son utilisation soulève des questions de proportionnalité : la vérification d'un billet peut se faire par QR code sans biométrie.

Recommandation : renoncer à la reconnaissance faciale et maintenir la validation par QR code. Si la biométrie est maintenue, informer clairement les participant·e·s, obtenir leur consentement explicite, et effacer les photos après validation.

### 4.2a - Données personnelles vs non personnelles

**Données personnelles** : email du·de la participant·e, code postal du·de la participant·e, historique des achats lié à un compte participant·e

**Données non personnelles** : nombre total de billets vendus pour un concert, nom de l'artiste, capacité maximale d'une scène

### 4.2b - Partage des données de fréquentation

Deux mesures concrètes avant de partager :
1. **Anonymisation / agrégation** : ne partager que des statistiques agrégées (ex : 8 200 spectateur·rice·s le samedi, 40% de 18-30 ans), sans aucune donnée individuelle identifiable. Vérifier que les agrégats ne permettent pas de ré-identification.
2. **Convention de traitement des données** : formaliser par contrat ce que le partenaire média peut faire avec les données, la durée de conservation, et l'interdiction de les céder à des tiers. Vérifier que la finalité du partage est compatible avec celle annoncée aux participant·e·s lors de la collecte.

### 4.2c - Newsletter sans consentement

Problème : le festival envoie des emails à des personnes qui n'ont pas donné leur accord pour recevoir des communications marketing. Cela viole le principe de **finalité déterminée** : les données ont été collectées pour gérer la billetterie, pas pour faire de la promotion. L'envoi de newsletter constitue un traitement ultérieur incompatible avec la finalité initiale.

Correction :
- Ne pas utiliser les emails collectés lors de l'achat de billets à des fins marketing sans consentement explicite.
- Ajouter une case à cocher optionnelle lors de l'inscription : "J'accepte de recevoir des informations sur les prochaines éditions."
- Permettre à tou·te·s les participant·e·s de se désabonner facilement.
