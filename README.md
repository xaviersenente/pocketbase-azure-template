# CRD PocketBase

Backend [PocketBase](https://pocketbase.io/) pour le projet CRD, déployable via Docker.

## Collections

Le schéma de la base de données est défini via des migrations JavaScript dans le dossier `pb_migrations/`.

### `event`

| Champ       | Type       | Requis | Description                          |
| ----------- | ---------- | ------ | ------------------------------------ |
| `id`        | text (15)  | oui    | Identifiant auto-généré (clé primaire) |
| `title`     | text       | oui    | Titre de l'événement                 |
| `published` | bool       | non    | Indique si l'événement est publié    |
| `created`   | autodate   | auto   | Date de création                     |
| `updated`   | autodate   | auto   | Date de dernière modification        |

**Règles d'accès :**

- **Liste** : `published = true` — seuls les événements publiés sont listés.
- **Vue** : `published = true` — seuls les événements publiés sont visibles.

### `page`

| Champ         | Type           | Requis | Description                             |
| ------------- | -------------- | ------ | --------------------------------------- |
| `id`          | text (15)      | oui    | Identifiant auto-généré (clé primaire)  |
| `published`   | bool           | non    | Indique si la page est publiée          |
| `title`       | text           | non    | Titre de la page                        |
| `imgFile`     | file           | oui    | Image (JPEG ou WebP)                    |
| `imgAlt`      | text           | oui    | Texte alternatif de l'image             |
| `excerpt`     | text           | oui    | Extrait / résumé                        |
| `description` | editor (HTML)  | oui    | Contenu détaillé                        |
| `created`     | autodate       | auto   | Date de création                        |
| `updated`     | autodate       | auto   | Date de dernière modification           |

**Règles d'accès :**

- **Liste** : `published = true` — seules les pages publiées sont listées.
- **Vue** : `published = true` — seules les pages publiées sont visibles.

## Déploiement avec Docker

Le `Dockerfile` utilise PocketBase **v0.36.2** sur Alpine Linux.

### Construire l'image

```bash
docker build -t crd-pocketbase .
```

### Lancer le conteneur

```bash
docker run -p 8080:8080 crd-pocketbase
```

L'interface d'administration est ensuite accessible à l'adresse : **http://localhost:8080/_/**

### Persistence des données

Pour conserver les données entre les redémarrages, montez un volume sur `/pb/pb_data` :

```bash
docker run -p 8080:8080 -v ./pb_data:/pb/pb_data crd-pocketbase
```

## API

Une fois le serveur lancé, l'API REST est disponible sur le port **8080**. Exemples :

```
GET /api/collections/event/records   # Liste des événements publiés
GET /api/collections/page/records    # Liste des pages publiées
```

Consultez la [documentation PocketBase](https://pocketbase.io/docs/) pour l'ensemble des endpoints disponibles.
