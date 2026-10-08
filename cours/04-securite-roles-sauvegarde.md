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

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-lock /></template>
Qui peut faire quoi dans la base, comment supprimer une donnée, et comment ne jamais la perdre.
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
GRANT SELECT (latitude, longitude)
  ON mobilier TO citoyen;

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

# Sauvegarde

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

Une sauvegarde jamais testée n'est pas une sauvegarde : c'est un espoir.

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
Restaurer régulièrement sur une base de test.
</Card>
<Card title="Hors site">
<template #icon><pixelarticons-cloud-upload /></template>
Une copie sur un serveur distant ou un stockage objet.
</Card>
<Card title="Rétention">
<template #icon><pixelarticons-archive /></template>
Quotidienne 7 jours, hebdomadaire 4 semaines, mensuelle 12 mois.
</Card>

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

### J3 · Sécurité

1. Créer les rôles `citoyen`, `technicien`, `responsable`
2. Lecture seule pour `citoyen`
3. Écriture pour `technicien`
4. Tester chaque rôle avec un compte dédié

::right::

### Sauvegarde

1. Sauvegarder la base en format custom
2. La restaurer dans une base vide
3. Vérifier le nombre de lignes

<Card color="#6b7280" tag="note" title="Suppression">
<template #icon><pixelarticons-trash /></template>
Choisir et justifier : suppression physique ou logique des signalements.
</Card>

---
layout: default
---

# Ressources

- [PostgreSQL · Database Roles](https://www.postgresql.org/docs/current/user-manag.html)
- [PostgreSQL · Privileges](https://www.postgresql.org/docs/current/ddl-priv.html)
- [PostgreSQL · pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html)
- [PostgreSQL · pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html)
- [PostgreSQL · Backup and Restore](https://www.postgresql.org/docs/current/backup.html)

<Card title="Prochain cours" color="#e92528" footer="cours 05 · Structures et architectures">
<template #icon><pixelarticons-arrow-right /></template>
NoSQL, systèmes distribués, flux de données et architectures modernes.
</Card>
