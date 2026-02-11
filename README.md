# PocketBase Azure Template

Template de déploiement [PocketBase](https://pocketbase.io/) sur Azure avec support Docker et GitHub Container Registry (GHCR).

## 🚀 Déploiement sur Azure Web App

Ce template utilise l'image Docker automatiquement construite et publiée sur GitHub Container Registry (GHCR).

### Étape 1 : Créer une Web App depuis le portail Azure

1. **Abonnement** : Sélectionnez `Azure for Students`

2. **Groupe de ressources** : Cliquez sur `Créer nouveau` et donnez-lui un nom

3. **Détails de l'instance** :
   - **Nom de l'application web** : Choisissez un nom unique (ex: `mon-pocketbase`)
   - **Sécurisez le nom d'hôte par défaut unique activé** : `Non` (décoché)
   - **Publier** : `Conteneur`
   - **Système d'exploitation** : `Linux`
   - **Région** : `France Central`

4. **Plan App Service** :
   - **Plan Linux** : Cliquez sur `Créer nouveau` et donnez-lui un nom
   - **Plan tarifaire** : `Gratuit F1`

### Étape 2 : Configuration du conteneur

Dans l'onglet **Conteneur** :

- **Source d'image** : `Autre registres de conteneurs`
- **Nom** : `main`
- **Options** : `Docker Hub`
- **Type d'accès** : `Public`
- **URL du serveur de Registre** : `https://ghcr.io`
- **Image et étiquette** : `xaviersenente/pocketbase-azure-template:0.36.2`
- **Port** : `8090`

### Étape 3 : Configuration après le déploiement

Une fois la Web App créée, configurez les variables d'environnement :

1. Allez dans **Configuration** > **Paramètres de l'application**
2. Ajoutez les variables d'environnement suivantes :

| Nom                                   | Valeur |
| ------------------------------------- | ------ |
| `WEBSITES_ENABLE_APP_SERVICE_STORAGE` | `true` |
| `WEBSITES_PORT`                       | `8090` |

3. **Enregistrez** les modifications

### Étape 4 : Récupérer l'URL de création du compte superuser

1. Allez dans **Centre de déploiement** > **Journaux**
2. Consultez les logs du démarrage du conteneur
3. Recherchez l'URL de création du compte administrateur
4. Remplacez `127.0.0.1:8090` par votre URL Azure (ex: `mon-pocketbase.azurewebsites.net`)
5. Accédez à cette URL pour créer votre compte superuser

## 📦 CI/CD avec GitHub Actions

Le workflow [.github/workflows/ghcr.yml](.github/workflows/ghcr.yml) construit automatiquement l'image Docker et la publie sur GHCR :

- ✅ Build multi-plateforme (linux/amd64, linux/arm64)
- ✅ Publication automatique sur push vers `main`
- ✅ Tagging avec SHA du commit et versions sémantiques
- ✅ Image disponible sur `ghcr.io/xaviersenente/pocketbase-azure-template`

## 🔧 Configuration des collections

Les collections peuvent être créées et configurées directement via l'interface d'administration PocketBase accessible à `https://<votre-app>.azurewebsites.net/_/`.

Vous pouvez également importer des collections existantes via l'interface en utilisant la fonctionnalité d'import/export de PocketBase.

L'interface d'administration est accessible à : `https://<votre-app>.azurewebsites.net/_/`

Consultez la [documentation PocketBase](https://pocketbase.io/docs/) pour plus de détails.
