---
theme: default
download: true
title: "06 - Sécurité, rôles et sauvegarde"
drawings:
    persist: false
transition: slide-left
mdc: true
fonts:
  sans: Roboto
  serif: Roboto Slab
  mono: Roboto Mono
layout: none
---

<div class="cover-custom">
  <img src="/images/logo.png" class="cover-logo" />
  <div class="cover-content">
    <h1 class="cover-title">06 - Sécurité, rôles et sauvegarde</h1>
    <p class="cover-subtitle">Infrastructure de données</p>
    <div style="display: flex; align-items: center; gap: 0.75rem; margin-top: 0.5rem;">
      <a target="_blank" href="https://github.com/MediaComem/comem-infradon" class="cover-email" style="display: flex; align-items: center; gap: 0.25rem;"><carbon-logo-github /> GitHub</a>
      <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/"><img src="https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg" style="height: 12px; opacity: 0.6;" /></a>
    </div>
    <div class="cover-meta">
      <span class="cover-author">Noemi Romano</span>
      <a href="mailto:noemi.romano@heig-vd.ch" class="cover-email">noemi.romano@heig-vd.ch</a>
      <span class="cover-date">{{ new Date().toLocaleDateString('fr-CH') }}</span>
    </div>
  </div>
</div>

---
layout: section
---

# Pourquoi sécuriser ?

---
layout: default
---

# Sécurité

<div class="mt-5" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; font-size: 0.84rem;">

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-locked style="color: #666;" /> Confidentialité</div>
  Protéger les données sensibles contre tout accès non autorisé
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-user style="color: #666;" /> Contrôle d'accès</div>
  Empêcher les intrusions et limiter qui peut faire quoi
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-warning style="color: #666;" /> Prévention des pertes</div>
  Éviter la suppression ou la corruption accidentelle de données
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-checkmark style="color: #666;" /> Intégrité</div>
  Garantir des données fiables et cohérentes dans le temps
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-document style="color: #666;" /> Conformité</div>
  Respecter les lois et régulations (RGPD, LPD, etc.)
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-analytics style="color: #666;" /> Protection financière</div>
  Réduire les risques d'amendes et de perte d'image
</div>

</div>

---
layout: default
---

# Concepts de base

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Utilisateur·rice·s

**Une identité** reconnue par le SGBD, avec des identifiants (login / mot de passe) et des droits d'accès définis

```sql
CREATE USER nom_utilisateur;
```

### Rôles

**Groupe de permissions** attribuables à plusieurs utilisateur·rice·s

```sql
CREATE ROLE nom_role;
```

### Privilèges

**Actions autorisées** à un·e utilisateur·rice ou à un rôle donné : lire, mettre à jour, supprimer…

</div>

<div class="flex items-center justify-center h-full">

<div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem; width: 100%;">

  <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem; border: 1.5px solid #d0d0d0; border-radius: 6px; padding: 0.55rem 1rem; width: 88%; font-size: 0.84rem; font-weight: 600;">
    <carbon-user style="color: #555;" /> Utilisateur·rice·s
  </div>

  <div style="color: #bbb; font-size: 1.1rem; line-height: 1.2;">↓</div>

  <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem; border: 1.5px solid #d0d0d0; border-radius: 6px; padding: 0.55rem 1rem; width: 88%; font-size: 0.84rem; font-weight: 600;">
    <carbon-group style="color: #555;" /> Rôles
  </div>

  <div style="color: #bbb; font-size: 1.1rem; line-height: 1.2;">↓</div>

  <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem; border: 1.5px solid #d0d0d0; border-radius: 6px; padding: 0.55rem 1rem; width: 88%; font-size: 0.84rem; font-weight: 600;">
    <carbon-security style="color: #555;" /> Privilèges
  </div>

  <div style="color: #bbb; font-size: 1.1rem; line-height: 1.2;">↓</div>

  <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem; border: 1.5px solid #d0d0d0; border-radius: 6px; padding: 0.55rem 1rem; width: 88%; font-size: 0.84rem; font-weight: 600;">
    <carbon-document style="color: #555;" /> Tables / Objets
  </div>

</div>

</div>

</div>

---
layout: default
---

# Créer des utilisateur·rice·s et des rôles

<div class="grid grid-cols-2 gap-8 mt-6">

<div>

### Utilisateur·rice·s

Un utilisateur peut se connecter à la base

```sql
CREATE USER alice WITH PASSWORD 'motdepasse';
```

Options courantes :

```sql
CREATE USER bob
  WITH PASSWORD 'motdepasse'
  VALID UNTIL '2026-12-31'
  NOSUPERUSER
  NOCREATEDB;
```

</div>

<div>

### Rôles

Un rôle est un groupe de permissions, il ne se connecte pas directement

```sql
CREATE ROLE lectrice;
CREATE ROLE editeur;
CREATE ROLE responsable;
```

Supprimer :

```sql
DROP USER alice;
DROP ROLE lectrice;
```

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/sql-createuser.html">PostgreSQL · CREATE USER</a> · <a href="https://www.postgresql.org/docs/current/sql-createrole.html">CREATE ROLE</a></div>

---
layout: default
---

# Commandes principales : GRANT et REVOKE

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### GRANT

Permet d'**accorder** un privilège à une personne utilisatrice ou à un rôle

```sql
GRANT <privilège> ON <objet>
  TO <utilisateur·rice ou rôle>;
```

Exemples :

```sql
GRANT SELECT, UPDATE ON produits TO employe;

GRANT ALL PRIVILEGES ON ventes TO responsable;

GRANT SELECT ON clients TO lectrice;
```

</div>

<div>

### REVOKE

Permet de **retirer** un privilège précédemment accordé

```sql
REVOKE <privilège> ON <objet>
  FROM <utilisateur·rice ou rôle>;
```

Exemples :

```sql
REVOKE INSERT ON commandes FROM editeur;

REVOKE ALL PRIVILEGES ON ventes FROM stagiaire;
```

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/sql-grant.html">PostgreSQL · GRANT</a> · <a href="https://www.postgresql.org/docs/current/sql-revoke.html">REVOKE</a></div>

---
layout: default
---

# Types de privilèges

<div class="grid grid-cols-2 gap-8 mt-4">

<div style="font-size: 0.85rem;">

| Privilège | Description |
|-----------|-------------|
| **SELECT** | Lire les données d'une table |
| **INSERT** | Ajouter de nouvelles lignes |
| **UPDATE** | Modifier des lignes existantes |
| **DELETE** | Supprimer des lignes |
| **CREATE** | Créer de nouveaux objets (tables, vues…) |
| **DROP** | Supprimer des objets |
| **EXECUTE** | Exécuter des procédures stockées |

</div>

<div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem; margin-bottom: 1rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-information style="color: #666;" /> Granularité</div>
  Sur toute la base, sur des tables spécifiques, ou sur des <strong>colonnes individuelles</strong>
</div>

```sql
-- Colonne spécifique
GRANT SELECT (nom, prenom) ON clients TO lectrice;

-- Toute la base
GRANT CONNECT ON DATABASE mydb TO alice;

-- Tous les privilèges
GRANT ALL PRIVILEGES ON ventes TO responsable;
```

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/ddl-priv.html">PostgreSQL · PRIVILEGES</a></div>

---
layout: default
---

# Utiliser des rôles

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

L'utilisation de rôles permet de :

- **Simplifier** l'attribution des permissions
- Gérer les permissions de façon **cohérente** et **évolutive**
- Faciliter le respect du **principe du moindre privilège**

```sql
-- Créer un rôle avec ses permissions
CREATE ROLE lectrice;
GRANT SELECT ON clients TO lectrice;

-- Attribuer le rôle à des utilisateur·rice·s
GRANT lectrice TO utilisateur1;
GRANT lectrice TO utilisateur2;

-- Retirer le rôle
REVOKE lectrice FROM utilisateur1;
```

</div>

<div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem; margin-bottom: 1rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.15rem;"><carbon-security style="color: #666;" /> Principe du moindre privilège (PoLP)</div>
  N'accorder que les permissions <strong>strictement nécessaires</strong> pour effectuer ses tâches → ni plus, ni moins
</div>

<div class="mt-4" style="font-size: 0.84rem;">

| Rôle | Permissions |
|------|-------------|
| `lectrice` | SELECT sur les tables publiques |
| `editeur` | SELECT, INSERT, UPDATE |
| `responsable` | ALL PRIVILEGES |

</div>

</div>

</div>

---
layout: default
---

# Bonnes pratiques générales

<div class="mt-5" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; font-size: 0.84rem;">

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-security style="color: #666;" /> Moindre privilège</div>
  Donner uniquement les droits nécessaires, ne jamais accorder <code>ALL PRIVILEGES</code> par défaut
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-group style="color: #666;" /> Utiliser des rôles</div>
  Gérer les permissions par groupes, pas individuellement
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-password style="color: #666;" /> Mots de passe forts et changés régulièrement</div>
  Utiliser <code>VALID UNTIL</code> pour forcer le renouvellement
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-trash-can style="color: #666;" /> Supprimer les accès inutiles</div>
  Réduire la surface d'attaque en supprimant les comptes inactifs et les rôles obsolètes
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem; grid-column: span 2;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-activity style="color: #666;" /> Monitorer</div>
  Surveiller et auditer les accès via les logs PostgreSQL (<code>pg_log</code>) ou l'extension <code>pgaudit</code>
</div>

</div>

---
layout: section
---

# Sauvegarde et restauration

<p class="section-subtitle">pg_dump et pg_restore</p>

---
layout: default
---

# Pourquoi sauvegarder ?

<div class="mt-5" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; font-size: 0.84rem;">

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-user style="color: #666;" /> Erreurs humaines</div>
  Un <code>DELETE</code> ou <code>DROP TABLE</code> sans <code>WHERE</code> peut détruire des données en quelques secondes
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-warning-alt style="color: #666;" /> Pannes matérielles</div>
  Disque défaillant, serveur qui tombe, coupure électrique
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-warning style="color: #666;" /> Attaques</div>
  Ransomware, corruption volontaire, accès non autorisé
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-migrate style="color: #666;" /> Migrations</div>
  Déplacer une base vers un autre serveur ou environnement (dev → prod)
</div>

</div>

<div style="background: #fffbe6; border: 1px solid #f0d060; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem; margin-top: 1rem; display: flex; align-items: center; gap: 0.5rem;">
  <carbon-warning-alt style="color: #c8a000; flex-shrink: 0;" /> Une sauvegarde qui n'a jamais été testée n'est pas une sauvegarde → c'est un espoir
</div>

---
layout: default
---

# pg_dump dans Docker Desktop

<div class="grid grid-cols-2 gap-8 mt-4" style="font-size: 0.85rem;">

<div>

**Étape 1 : Ouvrir un terminal dans le conteneur**

Dans Docker Desktop, cliquer sur le conteneur PostgreSQL en cours d'exécution, puis sur l'onglet **Exec**

<div class="mt-3" style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.15rem;"><carbon-terminal style="color: #666;" /> Terminal dans le conteneur</div>
  Le terminal s'ouvre directement à l'intérieur du conteneur, PostgreSQL et <code>pg_dump</code> y sont déjà disponibles
</div>

**Étape 2 : Lancer la sauvegarde**

```bash
pg_dump -U postgres -d mabase \
  -F c -f /tmp/backup.dump
```

</div>

<div>

**Étape 3 : Récupérer le fichier**

Dans Docker Desktop, onglet **Files** → naviguer jusqu'à `/tmp` → clic droit sur `backup.dump` → **Save**

<div class="mt-3" style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.15rem;"><carbon-information style="color: #666;" /> Alternative via terminal local</div>
  Si un terminal est disponible sur la machine hôte, copier le fichier avec :

```bash
docker cp nom_conteneur:/tmp/backup.dump ./backup.dump
```

</div>

**Étape 4 : Restaurer**

Même démarche : onglet Exec, puis :

```bash
pg_restore -U postgres -d mabase /tmp/backup.dump
```

</div>

</div>

---
layout: default
---

# pg_dump : sauvegarder une base

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

`pg_dump` exporte le contenu d'une base de données en un fichier de sauvegarde

```bash
pg_dump -U nom_utilisateur \
        -d nom_base \
        -f sauvegarde.sql
```

Options essentielles :

| Option | Description |
|--------|-------------|
| `-U` | Utilisateur·rice PostgreSQL |
| `-d` | Nom de la base |
| `-f` | Fichier de sortie |
| `-F` | Format de sortie |

</div>

<div>

`pg_dump` ne sauvegarde **qu'une seule base** à la fois

Il n'exporte **pas** les rôles ni les mots de passe → pour cela, utiliser `pg_dumpall`

```bash
# Sauvegarder depuis un serveur distant
pg_dump -U postgres \
        -h mon-serveur.example.com \
        -p 5432 \
        -d mabase \
        -f sauvegarde.sql
```

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/app-pgdump.html">PostgreSQL · pg_dump</a></div>

---
layout: default
---

# pg_dump : formats de sortie

<div class="mt-4" style="font-size: 0.85rem;">

| Format | Option | Extension | Description |
|--------|--------|-----------|-------------|
| **Plain SQL** | `-F p` | `.sql` | Fichier texte SQL lisible, restaurable avec `psql` |
| **Custom** | `-F c` | `.dump` | Format binaire compressé, restauration sélective possible |
| **Tar** | `-F t` | `.tar` | Archive tar, restaurable avec `pg_restore` |
| **Directory** | `-F d` | dossier | Un fichier par table, parallélisable |

</div>

<div class="grid grid-cols-2 gap-6 mt-4" style="font-size: 0.84rem;">

<div>

```bash
# Format plain SQL (défaut)
pg_dump -U postgres -d mabase \
  -F p -f sauvegarde.sql

# Format custom (recommandé)
pg_dump -U postgres -d mabase \
  -F c -f sauvegarde.dump

# Format directory (parallèle)
pg_dump -U postgres -d mabase \
  -F d -f dossier_sauvegarde/
```

</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.84rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.2rem;"><carbon-information style="color: #666;" /> Format recommandé</div>
  <strong>Custom</strong> (<code>-F c</code>) : compression intégrée, restauration sélective, compatible <code>pg_restore</code><br/><br/>
  <strong>Plain SQL</strong> (<code>-F p</code>) : lisible mais sans restauration sélective → utiliser <code>psql</code> pour restaurer
</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/app-pgdump.html">PostgreSQL · pg_dump</a></div>

---
layout: default
---

# pg_dump : options avancées

<div class="grid grid-cols-2 gap-8 mt-4" style="font-size: 0.85rem;">

<div>

**Sauvegarder une table spécifique**

```bash
pg_dump -U postgres -d mabase \
  -t ma_table \
  -f ma_table.sql
```

**Sauvegarder uniquement le schéma** (sans données)

```bash
pg_dump -U postgres -d mabase \
  -s -f schema_only.sql
```

**Sauvegarder uniquement les données** (sans schéma)

```bash
pg_dump -U postgres -d mabase \
  -a -f data_only.sql
```

</div>

<div>

**Exclure une table**

```bash
pg_dump -U postgres -d mabase \
  --exclude-table=logs \
  -f sauvegarde.sql
```

**Sauvegarder toutes les bases + rôles**

```bash
pg_dumpall -U postgres \
  -f tout.sql
```

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.83rem; margin-top: 0.8rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-information style="color: #666;" /> pg_dumpall</div>
  Inclut les rôles, les mots de passe (hashés) et toutes les bases → utile pour migrer un serveur entier
</div>

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/app-pg-dumpall.html">PostgreSQL · pg_dumpall</a></div>

---
layout: default
---

# pg_restore : restaurer une sauvegarde

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

`pg_restore` restaure une sauvegarde en format **custom**, **tar** ou **directory**

```bash
pg_restore -U nom_utilisateur \
           -d nom_base \
           sauvegarde.dump
```

Options essentielles :

| Option | Description |
|--------|-------------|
| `-U` | Utilisateur·rice PostgreSQL |
| `-d` | Base de destination |
| `-v` | Mode verbose |
| `-j N` | Restauration parallèle |

</div>

<div>

La base de destination **doit exister** avant la restauration :

```bash
# Créer la base vide
psql -U postgres -c "CREATE DATABASE mabase;"

# Puis restaurer
pg_restore -U postgres \
           -d mabase \
           sauvegarde.dump
```

Pour un fichier **plain SQL**, utiliser `psql` à la place :

```bash
psql -U postgres \
     -d mabase \
     -f sauvegarde.sql
```

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/app-pgrestore.html">PostgreSQL · pg_restore</a></div>

---
layout: default
---

# pg_restore : options avancées

<div class="grid grid-cols-2 gap-8 mt-4" style="font-size: 0.85rem;">

<div>

**Restaurer une table spécifique**

```bash
pg_restore -U postgres -d mabase \
  -t ma_table \
  sauvegarde.dump
```

**Supprimer les objets avant de restaurer**

```bash
pg_restore -U postgres -d mabase \
  --clean \
  sauvegarde.dump
```

**Créer la base automatiquement**

```bash
pg_restore -U postgres \
  --create \
  -d postgres \
  sauvegarde.dump
```

</div>

<div>

**Restauration parallèle** (plus rapide sur les grandes bases)

```bash
pg_restore -U postgres -d mabase \
  -j 4 \
  sauvegarde.dump
```

**Lister le contenu d'une sauvegarde** (sans restaurer)

```bash
pg_restore --list sauvegarde.dump
```

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem; font-size: 0.83rem; margin-top: 0.8rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-information style="color: #666;" /> --clean</div>
  Supprime les objets existants avant de les recréer → utile pour écraser une base sans la recréer manuellement
</div>

</div>

</div>

<div class="footer"><a href="https://www.postgresql.org/docs/current/app-pgrestore.html">PostgreSQL · pg_restore</a></div>

---
layout: default
---

# Récapitulatif : pg_dump / pg_restore

<div class="mt-4" style="font-size: 0.85rem;">

| Action | Commande |
|--------|----------|
| Sauvegarder en SQL lisible | `pg_dump -U user -d db -F p -f backup.sql` |
| Sauvegarder en format custom | `pg_dump -U user -d db -F c -f backup.dump` |
| Sauvegarder une table | `pg_dump -U user -d db -t table -f table.sql` |
| Sauvegarder schéma seulement | `pg_dump -U user -d db -s -f schema.sql` |
| Sauvegarder toutes les bases | `pg_dumpall -U postgres -f all.sql` |
| Restaurer (format custom/tar) | `pg_restore -U user -d db backup.dump` |
| Restaurer (plain SQL) | `psql -U user -d db -f backup.sql` |
| Restaurer une table | `pg_restore -U user -d db -t table backup.dump` |
| Lister le contenu | `pg_restore --list backup.dump` |

</div>

---
layout: default
---

# Bonnes pratiques de sauvegarde

<div class="mt-5" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; font-size: 0.84rem;">

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.2rem;"><carbon-repeat style="color: #666;" /> Automatiser les sauvegardes</div>
  Planifier avec <code>cron</code> ou un outil dédié, ne pas compter sur les sauvegardes manuelles

```bash
0 2 * * * pg_dump -U postgres -d mabase \
  -F c -f /backups/mabase_$(date +\%Y\%m\%d).dump
```

</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-checkmark style="color: #666;" /> Tester la restauration</div>
  Vérifier régulièrement que la sauvegarde est bien restaurable sur une base de test
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-cloud-upload style="color: #666;" /> Stocker hors site</div>
  Conserver les sauvegardes sur un serveur distant ou dans un stockage cloud (S3, etc.)
</div>

<div style="background: #fafaf0; border: 1px solid #e5dfc5; border-radius: 4px; padding: 0.55rem 0.85rem;">
  <div style="display: flex; align-items: center; gap: 0.35rem; font-weight: 600; margin-bottom: 0.1rem;"><carbon-calendar style="color: #666;" /> Politique de rétention</div>
  Quotidien 7j, hebdomadaire 4 semaines, mensuel 12 mois
</div>

</div>

---
layout: default
---

# Projet 

<div class="mt-6">

### Livrable


Créer les rôles adaptés au contexte du Service technique :

  - Lecture seule pour les citoyen·ne·s
  - Écriture pour les technicien·ne·s
  - Tous les privilèges pour les administrateur·rice·s

</div>
