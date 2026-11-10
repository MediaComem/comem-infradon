# Révisions pour l'examen final - InfraDon

Ce dossier contient un [examen type](examen-type.md) pour vous préparer à l'examen final.

> **Durée :** 2h, sur papier\
> **Documents autorisés :** une feuille A4 recto-verso manuscrite

## Ce qu'il faut maîtriser pour l'examen

- [Cours 1 - Introduction](../cours/01-introduction.md) : composants d'une infrastructure, flux de données, modèles de déploiement, rôle de Docker et de Git
- [Cours 2 - Import et nettoyage](../cours/02-import-nettoyage.md) : qualité des données, staging, fonctions de nettoyage, propagation des erreurs, rejets et traçabilité, idempotence et ON CONFLICT
- [Cours 3 - Transactions et concurrence](../cours/03-transactions-concurrence.md) : propriétés ACID, anomalies de concurrence, niveaux d'isolation, MVCC, verrous et FOR UPDATE, interblocages, coût de la cohérence (lire une mesure pgbench)
- [Cours 4 - Sécurité, rôles et sauvegarde](../cours/04-securite-roles-sauvegarde.md) : GRANT/REVOKE, moindre privilège, audit des rôles, suppression physique ou logique, RPO et RTO, pg_dump/pg_restore, réplication et sauvegarde, scénarios de panne
- [Cours 5 - Structures et architectures](../cours/05-structures-architectures.md) : JSONB et index GIN, lire un EXPLAIN ANALYZE, vues matérialisées, familles NoSQL, CAP et BASE, OLTP/OLAP, ETL/ELT, medallion, lakehouse, data mesh, over-engineering
- [Cours 6 - Éthique des données](../cours/06-ethique-donnees.md) : gouvernance, indicateurs de qualité, données personnelles et sensibles, principes de la nLPD, audit de conformité, pseudonymisation, empreinte environnementale, souveraineté numérique, biais dans les données et dans le schéma

Chaque TP se termine par une question au format de l'examen. Les corrigés des TP sont publiés une semaine après la séance.
