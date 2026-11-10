---
theme: pixel
number: "04"
title: "Sécurité, rôles et sauvegarde"
subtitle: "Infrastructure de Données"
author: "Noemi Romano"
email: "noemi.romano@heig-vd.ch"
github: "https://github.com/MediaComem/comem-infradon"
breadcrumb: "Infrastructure de Données"
logos:
  - /images/logo-heig-vd.svg
  - src: /images/logo-hes-so.png
    height: 79px

download: true
mdc: true
layout: cover
---

---
layout: default
---

# Cours précédent

- Transactions et garanties ACID
- Anomalies de concurrence
- Niveaux d'isolation de PostgreSQL
- MVCC, verrous et interblocages
- Coût de la cohérence, mesuré avec `pgbench`

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-lock /></template>
Qui peut faire quoi dans la base, comment supprimer une donnée, et comment résister à une panne, une erreur ou une fuite.
</Card>

---
layout: section
---

# Sécurité

---
layout: grid
cols: 3
align: stretch
content: center
---

# Objectifs de sécurité

<Card title="Confidentialité">
<template #icon><pixelarticons-lock /></template>
Protéger les données sensibles de tout accès non autorisé.
</Card>
<Card title="Contrôle d'accès">
<template #icon><pixelarticons-user /></template>
Limiter qui peut faire quoi.
</Card>
<Card title="Prévention des pertes">
<template #icon><pixelarticons-shield /></template>
Éviter la suppression ou la corruption accidentelle.
</Card>
<Card title="Intégrité">
<template #icon><pixelarticons-check-double /></template>
Des données fiables et cohérentes dans le temps.
</Card>
<Card title="Conformité">
<template #icon><pixelarticons-file-text /></template>
Respecter la nLPD et le RGPD.
</Card>
<Card title="Protection financière">
<template #icon><pixelarticons-coin /></template>
Limiter amendes et atteinte à la réputation.
</Card>

---
layout: grid
cols: 3fr 1fr 3fr 1fr 3fr
align: stretch
content: center
---

# Utilisateur·rice, rôle, privilège

<Card title="Utilisateur·rice">
<template #icon><pixelarticons-user /></template>
Une identité qui se connecte, avec un mot de passe.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Rôle">
<template #icon><pixelarticons-users /></template>
Un groupe de privilèges, attribué à plusieurs personnes.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Privilège">
<template #icon><pixelarticons-lock-open /></template>
Une action autorisée sur une table : lire, modifier, supprimer.
</Card>

---
layout: two-cols
---

::title::
# Exemple : rôles du Service technique

::left::

### Besoins

> « Les citoyen·ne·s consultent les signalements. Les technicien·ne·s les traitent. Moi, je gère tout. »

### La question

Quels rôles, avec quels privilèges ?

::right::

<v-click>

```sql
CREATE ROLE citoyen;
GRANT SELECT ON signalements TO citoyen;

CREATE ROLE technicien;
GRANT SELECT, INSERT, UPDATE
  ON signalements, interventions
  TO technicien;

CREATE ROLE responsable;
GRANT ALL PRIVILEGES
  ON ALL TABLES IN SCHEMA public
  TO responsable;

GRANT technicien TO alice;
```

</v-click>

<v-click>

- Un rôle par profil
- Les personnes héritent du rôle

</v-click>

---
layout: grid
cols: 2
align: stretch
content: center
---

# Bonnes pratiques d'accès

<Card title="Moindre privilège">
<template #icon><pixelarticons-shield /></template>
Uniquement les droits nécessaires. Jamais <code>ALL PRIVILEGES</code> par défaut.
</Card>
<Card title="Rôles">
<template #icon><pixelarticons-users /></template>
Des privilèges par groupe, jamais personne par personne.
</Card>
<Card title="Mots de passe">
<template #icon><pixelarticons-lock /></template>
Forts et renouvelés : <code>VALID UNTIL</code> impose l'expiration.
</Card>
<Card title="Nettoyage">
<template #icon><pixelarticons-trash /></template>
Supprimer comptes inactifs et rôles obsolètes.
</Card>
<Card title="Audit">
<template #icon><pixelarticons-eye /></template>
Journaux PostgreSQL ou extension <code>pgaudit</code>.
</Card>

---
layout: two-cols
---

::title::
# Pièges courants

::left::

- Application connectée en **superuser**
- Compte **partagé** : impossible de savoir qui a fait quoi
- Compte d'une personne **partie**, toujours actif
- `GRANT ... TO PUBLIC` : tous les rôles, présents et futurs
- `ON ALL TABLES` : y compris les tables ajoutées par erreur

::right::

<Card color="#d97706" tag="warning" title="Accumulation">
<template #icon><pixelarticons-alert /></template>
Chaque droit a été accordé pour une bonne raison. Personne ne les retire.
</Card>

<Card title="Superuser" color="#e92528">
<template #icon><pixelarticons-shield /></template>
Un superuser ignore tous les privilèges : un seul compte compromis donne la base entière.
</Card>

---
layout: two-cols
references: "PostgreSQL, <em>pg_roles</em>, <em>information_schema</em>"
---

::title::
# Audit des rôles

::left::

- Qui peut se connecter ? Qui est superuser ?
- Qui peut lire les données personnelles ?
- Chaque compte correspond-il à une personne active ?
- Chaque privilège a-t-il un besoin documenté ?
- À refaire à chaque départ et chaque année

::right::

```sql
SELECT rolname, rolsuper, rolcanlogin,
       rolvaliduntil
FROM pg_roles
WHERE rolname !~ '^pg_';

SELECT grantee, table_name,
       privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
ORDER BY grantee, table_name;
```

---
layout: two-cols
---

::title::
# Fuite de données

::left::

- Privilège trop large, compte volé
- Mot de passe écrit dans un dépôt Git
- Export CSV envoyé par email
- Sauvegarde copiée sur un poste ou un cloud personnel
- Base de test remplie de vraies données

::right::

<Card title="Sauvegarde" color="#d97706" tag="warning" footer="cours 06 · nLPD">
<template #icon><pixelarticons-copy /></template>
Un dump est une copie complète des données personnelles. Chiffrer, limiter l'accès, appliquer la rétention.
</Card>

<Card color="#6b7280" tag="note" title="Annonce">
<template #icon><pixelarticons-mail /></template>
nLPD, art. 24 : une fuite à risque élevé s'annonce au PFPDT dans les meilleurs délais.
</Card>

---
layout: section
---

# Suppression des données

---
layout: two-cols
---

::title::
# Suppression physique ou logique

::left::

- **Physique** : la ligne est effacée
- **Logique** : la ligne est marquée, conservée
- Colonne `deleted_at` ou `is_active`
- Engage audit, conformité, performances

::right::

```sql
-- Physique
DELETE FROM signalements WHERE id = 42;

-- Logique
UPDATE signalements
SET deleted_at = now()
WHERE id = 42;

SELECT * FROM signalements
WHERE deleted_at IS NULL;
```

---
layout: default
---

# Compromis de la suppression

| | Physique | Logique |
|---|---|---|
| Audit | Impossible | Possible |
| Retour en arrière | Impossible | Possible |
| Droit à l'effacement (nLPD, RGPD) | Direct | Complexe |
| Intégrité référentielle | Risque de cascade | Préservée |
| Volume | Stable | Croissant |
| Requêtes | Simples | Filtre `deleted_at IS NULL` |

<Card title="Paradoxe" color="#d97706" tag="warning">
<template #icon><pixelarticons-scale /></template>
Le droit à l'oubli oblige parfois à effacer ce qu'on voudrait garder pour l'audit.
</Card>

---
layout: section
---

# Sauvegarde et robustesse

---
layout: grid
cols: 2
align: stretch
content: center
---

# Raisons de sauvegarder

<Card title="Erreur humaine">
<template #icon><pixelarticons-user-x /></template>
Un <code>DELETE</code> sans <code>WHERE</code>, un <code>DROP TABLE</code> de trop.
</Card>
<Card title="Panne matérielle">
<template #icon><pixelarticons-server /></template>
Disque défaillant, serveur en panne, coupure électrique.
</Card>
<Card title="Attaque">
<template #icon><pixelarticons-bug /></template>
Rançongiciel, corruption volontaire, accès non autorisé.
</Card>
<Card title="Migration">
<template #icon><pixelarticons-move /></template>
Passer d'un serveur ou d'un environnement à l'autre.
</Card>

---
layout: two-cols
---

::title::
# RPO et RTO

::left::

- **RPO** : quelle perte de données est acceptable ?
- **RTO** : combien de temps sans service est acceptable ?
- Fixés par le métier, pas par l'informatique
- Ils déterminent la stratégie et son coût

::right::

| Stratégie | RPO | RTO |
|---|---|---|
| `pg_dump` chaque nuit | 24 h | Temps de restauration |
| Archivage des WAL | Quelques minutes | Restauration + rejeu |
| Réplica de secours | Quelques secondes | Bascule |

<Card color="#6b7280" tag="note" title="Service technique">
<template #icon><pixelarticons-calendar /></template>
Perdre une journée de signalements : acceptable ? Et une journée de paie ?
</Card>

---
layout: default
references:
  - "PostgreSQL, <em>Continuous Archiving and Point-in-Time Recovery</em>"
  - "PostgreSQL, <em>High Availability</em>"
---

# Trois façons de copier

| | Dump logique | Sauvegarde physique et WAL | Réplication |
|---|---|---|---|
| Outil | `pg_dump` | `pg_basebackup`, archivage | Réplica en continu |
| Contenu | Une base, en SQL | Tout le serveur, fichiers | Tout le serveur, en direct |
| Retour à 14 h 59 | Non | Oui : restauration à un instant | Non |
| Après un `DELETE` sans `WHERE` | Dernier dump | Juste avant l'erreur | Erreur répliquée |

<Card title="Réplication" color="#e92528">
<template #icon><pixelarticons-alert /></template>
Une réplication protège contre la panne du serveur, pas contre l'erreur : elle copie aussi le <code>DELETE</code>.
</Card>

---
layout: grid
cols: 2
align: stretch
content: center
---

# Bonnes pratiques de sauvegarde

<Card title="Automatiser">
<template #icon><pixelarticons-calendar /></template>
Une tâche planifiée, jamais une sauvegarde à la main.
</Card>
<Card title="Tester">
<template #icon><pixelarticons-check /></template>
Restaurer régulièrement sur une base de test, mesurer la durée.
</Card>
<Card title="Règle 3-2-1">
<template #icon><pixelarticons-cloud-upload /></template>
3 copies, sur 2 supports différents, dont 1 hors site. Idéalement une hors ligne.
</Card>
<Card title="Rétention">
<template #icon><pixelarticons-archive /></template>
Quotidienne 7 jours, hebdomadaire 4 semaines, mensuelle 12 mois.
</Card>

Une sauvegarde jamais testée n'est pas une sauvegarde : c'est un espoir.

---
layout: two-cols
---

::title::
# Exemple : sauvegarde nocturne

::left::

### Besoins

> « Je veux une sauvegarde chaque nuit, sans y penser. »

### La question

Comment planifier `pg_dump` ?

::right::

<v-click>

```bash
# crontab : chaque jour à 2h
0 2 * * * pg_dump -U postgres \
  -d yverdon -F c \
  -f /backups/yverdon_$(date +\%Y\%m\%d).dump
```

</v-click>

<v-click>

- Un fichier daté par nuit
- Copier ensuite hors site
- Supprimer selon la rétention

</v-click>

---
layout: default
class: compact
---

# Scénarios de panne

| Scénario | Ce qui protège | Ce qui ne protège pas |
|---|---|---|
| Disque du serveur détruit | Réplica, sauvegarde sur un autre support | Dump stocké sur le même disque |
| `DELETE` sans `WHERE` | Moindre privilège, transaction, dump, WAL | Réplication |
| Rançongiciel | Copie hors ligne, rôles cloisonnés | Copie montée en permanence |
| Incendie du bâtiment | Copie hors site | Réplica dans la même salle |
| Fuite par un compte | Moindre privilège, audit des rôles | Sauvegarde |

<Card title="À retenir" color="#e92528">
<template #icon><pixelarticons-shield /></template>
Chaque mesure couvre certains risques. La robustesse vient de leur combinaison.
</Card>

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# Travail pratique · Semaine 4

::left::

### Déroulé

1. Audit et moindre privilège : 75 min
2. Suppression logique : 30 min
3. Sauvegarde et incident : 60 min
4. Question type : 15 min

<Card color="#6b7280" tag="note" title="Non noté">
<template #icon><pixelarticons-book-open /></template>
Les exercices préparent l'examen final.
</Card>

::right::

### Départ

1. Télécharger [04-service-technique.sql](https://comem-infradon.onrender.com/exercices/04-service-technique.sql) et [04-incident.sql](https://comem-infradon.onrender.com/exercices/04-incident.sql)
2. Les copier dans le dossier `data`
3. Exécuter le premier dans `psql`, base `yverdon`

```sql
\i /data/04-service-technique.sql
```

Le second attend l'exercice 5.

---
layout: two-cols
references:
  - "PostgreSQL, <em>CREATE USER</em>"
  - "PostgreSQL, <em>CREATE ROLE</em>"
---

::title::
# Syntaxe : CREATE USER, CREATE ROLE

::left::

- `CREATE USER` : peut se connecter
- `CREATE ROLE` : groupe, sans connexion
- `VALID UNTIL` : date d'expiration du mot de passe
- `DROP` : supprimer

::right::

```sql
CREATE USER alice WITH PASSWORD 'motdepasse';

CREATE USER bob
  WITH PASSWORD 'motdepasse'
  VALID UNTIL '2027-12-31'
  NOSUPERUSER
  NOCREATEDB;

CREATE ROLE technicien;

DROP USER alice;
DROP ROLE technicien;
```

---
layout: two-cols
references:
  - "PostgreSQL, <em>GRANT</em>"
  - "PostgreSQL, <em>REVOKE</em>"
---

::title::
# Syntaxe : GRANT, REVOKE

::left::

- `GRANT` : accorder un privilège
- `REVOKE` : le retirer
- Sur une base, une table ou des colonnes
- À une personne ou à un rôle

::right::

```sql
GRANT privilege ON objet
  TO utilisateur_ou_role;

REVOKE privilege ON objet
  FROM utilisateur_ou_role;
```

---
layout: default
references: "PostgreSQL, <em>Privileges</em>"
---

# Privilèges

| Privilège | Autorise |
|---|---|
| `SELECT` | Lire les lignes |
| `INSERT` | Ajouter des lignes |
| `UPDATE` | Modifier des lignes |
| `DELETE` | Supprimer des lignes |
| `CREATE` | Créer des objets dans un schéma |
| `CONNECT` | Se connecter à une base |
| `EXECUTE` | Exécuter une fonction |

---
layout: two-cols
references: "PostgreSQL, <em>SET ROLE</em>, <em>System Information Functions</em>"
---

::title::
# Syntaxe : tester les droits

::left::

- `\du` : rôles et attributs, dans `psql`
- `\dp table` : privilèges d'une table
- `has_table_privilege` : vrai ou faux
- `SET ROLE` : agir avec les droits d'un rôle
- `RESET ROLE` : revenir à son rôle

::right::

```sql
SELECT has_table_privilege(
  'role_name', 'table_name', 'DELETE');

SET ROLE role_name;
SELECT * FROM table_name;  -- autorisé ?
RESET ROLE;

ALTER ROLE role_name NOLOGIN;
DROP OWNED BY role_name;
DROP ROLE role_name;
```

---
layout: two-cols
references: "PostgreSQL, <em>pg_dump</em>"
---

::title::
# Syntaxe : pg_dump

::left::

- Exporte **une** base dans un fichier
- `-U` utilisateur·rice, `-d` base
- `-f` fichier de sortie, `-F` format
- `-h` et `-p` : serveur distant
- Ni rôles ni mots de passe

::right::

```bash
pg_dump -U postgres \
        -d yverdon \
        -F c \
        -f sauvegarde.dump

pg_dump -U postgres \
        -h serveur.example.ch \
        -p 5432 \
        -d yverdon \
        -f sauvegarde.sql
```

---
layout: default
references: "PostgreSQL, <em>pg_dump</em>"
---

# Formats de sortie

| Format | Option | Fichier | Restauration |
|---|---|---|---|
| SQL lisible | `-F p` | `.sql` | `psql` |
| Custom | `-F c` | `.dump` | `pg_restore`, sélective |
| Tar | `-F t` | `.tar` | `pg_restore` |
| Dossier | `-F d` | dossier | `pg_restore`, en parallèle |

<Card title="Recommandé" color="#16a34a" tag="tip">
<template #icon><pixelarticons-check /></template>
<strong>Custom</strong> : compressé, restauration sélective. <strong>SQL lisible</strong> pour relire le contenu.
</Card>

---
layout: two-cols
references: "PostgreSQL, <em>pg_dumpall</em>"
---

::title::
# Options de pg_dump

::left::

- `-t` : une seule table
- `-s` : structure seule
- `-a` : données seules
- `--exclude-table` : exclure une table
- `pg_dumpall` : toutes les bases et les rôles

::right::

```bash
pg_dump -U postgres -d yverdon \
  -t mobilier -f mobilier.sql

pg_dump -U postgres -d yverdon \
  -s -f structure.sql

pg_dump -U postgres -d yverdon \
  -a -f donnees.sql

pg_dump -U postgres -d yverdon \
  --exclude-table=logs -f sauvegarde.sql

pg_dumpall -U postgres -f serveur.sql
```

---
layout: two-cols
references: "PostgreSQL, <em>pg_restore</em>"
---

::title::
# Syntaxe : pg_restore

::left::

- Restaure les formats custom, tar, dossier
- La base de destination doit exister
- `-j N` : restauration parallèle
- Format SQL lisible : `psql -f`

::right::

```bash
psql -U postgres \
  -c "CREATE DATABASE yverdon;"

pg_restore -U postgres \
           -d yverdon \
           sauvegarde.dump

psql -U postgres \
     -d yverdon \
     -f sauvegarde.sql
```

---
layout: two-cols
references: "PostgreSQL, <em>pg_restore</em>"
---

::title::
# Options de pg_restore

::left::

- `-t` : une seule table
- `--clean` : supprimer avant de recréer
- `--create` : créer la base
- `--list` : contenu, sans restaurer

::right::

```bash
pg_restore -U postgres -d yverdon \
  -t mobilier sauvegarde.dump

pg_restore -U postgres -d yverdon \
  --clean sauvegarde.dump

pg_restore -U postgres --create \
  -d postgres sauvegarde.dump

pg_restore --list sauvegarde.dump
```

---
layout: two-cols
---

::title::
# Sauvegarde avec Docker Desktop

::left::

1. Ouvrir le conteneur PostgreSQL, onglet **Exec**
2. Lancer `pg_dump` dans ce terminal
3. Onglet **Files** : enregistrer le fichier
4. Restaurer : `pg_restore` depuis **Exec**

::right::

```bash
pg_dump -U postgres -d yverdon \
  -F c -f /tmp/sauvegarde.dump

docker cp \
  conteneur:/tmp/sauvegarde.dump \
  ./sauvegarde.dump

pg_restore -U postgres -d yverdon \
  /tmp/sauvegarde.dump
```

---
layout: two-cols-bottom
---

::title::
# Exercice 1 : audit des rôles

::left::

### Étapes

1. Lister les rôles, leurs attributs et leurs commentaires
2. Lister les privilèges de chaque rôle
3. Vérifier ce que `PUBLIC` peut lire
4. Noter chaque problème et le risque associé

::right::

| rôle | problème | risque |
|---|---|---|
| | | |
| | | |
| | | |
| | | |

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Quel problème corriger en premier, et pourquoi ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 2 : moindre privilège

::left::

### Étapes

1. Corriger les problèmes de l'exercice 1
2. Créer les groupes `citoyen`, `technicien`, `responsable`
3. Créer `alice`, `bob`, `carla`, un par groupe
4. Tester chaque case du tableau avec `SET ROLE`

::right::

`signalement`, puis `technicien` (dernière colonne)

| | lire | insérer | supprimer | téléphones |
|---|---|---|---|---|
| bob | | | | |
| alice | | | | |
| carla | | | | |

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Que faire du compte <code>service_technique</code>, utilisé par toute l'équipe ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 3 : suppression logique

::left::

### Étapes

1. Ajouter `supprime_le` à `signalement`
2. Créer la vue `signalement_actif`
3. Donner à `citoyen` la vue, pas la table
4. Supprimer logiquement un signalement en tant qu'`alice`

::right::

```sql
SET ROLE alice;
UPDATE signalement
SET supprime_le = now()
WHERE id = 42;
RESET ROLE;

SET ROLE bob;
SELECT count(*) FROM signalement_actif;
SELECT count(*) FROM signalement;
RESET ROLE;
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Une citoyenne demande l'effacement de son signalement. La suppression logique suffit-elle ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 4 : sauvegarde et restauration

::left::

### Étapes

1. Sauvegarder `yverdon` en format custom, onglet **Exec**
2. Créer la base `yverdon_test`
3. Y restaurer la sauvegarde, en mesurant la durée
4. Comparer le nombre de lignes de chaque table

::right::

```bash
time pg_dump -U postgres -d yverdon \
  -F c -f /tmp/sauvegarde.dump

psql -U postgres \
  -c "CREATE DATABASE yverdon_test;"

time pg_restore -U postgres \
  -d yverdon_test /tmp/sauvegarde.dump
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Avec une sauvegarde chaque nuit, quel RPO ? Quel RTO pour cette base, et pour une base cent fois plus grande ?
</Card>

---
layout: two-cols-bottom
---

::title::
# Exercice 5 : incident

::left::

### Étapes

1. Exécuter `04-incident.sql` : une journée, puis l'erreur de 16 h
2. Constater les dégâts
3. Restaurer les données de la seule table `intervention`
4. Compter ce qui est revenu et ce qui est perdu

::right::

```sql
\i /data/04-incident.sql
SELECT count(*) FROM intervention;
```

```bash
pg_restore -U postgres -d yverdon \
  -a -t intervention /tmp/sauvegarde.dump
```

::bottom::

<Card title="Question" color="#e92528">
<template #icon><pixelarticons-scale /></template>
Combien d'interventions sont perdues ? Quelles mesures des exercices 2 et 3 auraient évité l'incident ?
</Card>

---
layout: two-cols
---

::title::
# Exercice 6 : question type

::left::

### Situation

> « Notre base est répliquée en continu sur un second serveur, dans la même salle. Une sauvegarde serait redondante. »

### Question

Pour chaque incident, la réplication suffit-elle ? Que proposer ?

::right::

| Incident |
|---|
| Le disque du serveur principal lâche |
| Un `DROP TABLE` est lancé par erreur |
| Un rançongiciel chiffre les deux serveurs |
| Une inondation touche la salle |

---
layout: default
---

# Ressources

- [PostgreSQL · Database Roles](https://www.postgresql.org/docs/current/user-manag.html)
- [PostgreSQL · Privileges](https://www.postgresql.org/docs/current/ddl-priv.html)
- [PostgreSQL · pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html)
- [PostgreSQL · pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html)
- [PostgreSQL · Backup and Restore](https://www.postgresql.org/docs/current/backup.html)
- [PostgreSQL · Point-in-Time Recovery](https://www.postgresql.org/docs/current/continuous-archiving.html)

<Card title="Prochain cours" color="#e92528" footer="cours 05 · Structures et architectures">
<template #icon><pixelarticons-arrow-right /></template>
Limites du relationnel, NoSQL, OLTP et OLAP, architectures analytiques.
</Card>
