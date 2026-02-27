# TP DevOps - Déploiement Automatisé avec Docker

[![Build and Push Docker Image](https://github.com/staniska973/devops-tp-docker/actions/workflows/docker-deploy.yml/badge.svg)](https://github.com/staniska973/devops-tp-docker/actions/workflows/docker-deploy.yml)

## 📋 Description

Application web conteneurisée avec pipeline CI/CD automatisé utilisant Docker, Nginx et GitHub Actions.

## 🚀 Technologies Utilisées

- **Docker** : Conteneurisation de l'application
- **Nginx Alpine** : Serveur web léger et performant
- **GitHub Actions** : Pipeline CI/CD automatique
- **GitHub Container Registry (GHCR)** : Hébergement des images Docker
- **HTML/CSS/JavaScript** : Interface utilisateur

## 📁 Structure du Projet

```
├── .github/
│   └── workflows/
│       └── docker-deploy.yml    # Workflow CI/CD
├── src/
│   ├── index.html              # Page principale
│   ├── style.css               # Styles CSS
│   └── app.js                  # Logique JavaScript
├── nginx/
│   └── nginx.conf              # Configuration Nginx
├── Dockerfile                   # Instructions Docker
├── .dockerignore               # Fichiers exclus du build
└── README.md                   # Documentation
```

## 🔧 Installation et Utilisation

### Prérequis

- Docker installé
- Git installé
- Compte GitHub

### Exécuter localement

```bash
# Cloner le repository
git clone https://github.com/staniska973/devops-tp-docker.git
cd devops-tp-docker

# Construire l'image Docker
docker build -t devops-tp-docker .

# Exécuter le container
docker run -d -p 8080:80 --name devops-container devops-tp-docker

# Ouvrir dans le navigateur
http://localhost:8080
```

### Utiliser l'image depuis GHCR

```bash
# Télécharger et exécuter l'image publiée
docker pull ghcr.io/staniska973/devops-tp-docker:latest
docker run -d -p 8080:80 ghcr.io/staniska973/devops-tp-docker:latest
```

## 🔄 Pipeline CI/CD

Le workflow GitHub Actions se déclenche automatiquement lors de :

- **Push** sur la branche `main` ou `develop`
- **Création de tag** (format `v*`)
- **Pull Request** vers `main`

### Actions automatiques :

1. Build de l'image Docker
2. Test de l'image
3. Push vers GitHub Container Registry
4. Versioning automatique avec tags

## 📦 Versions

Les images Docker sont taguées automatiquement :

- `latest` : Dernière version de la branche main
- `v1.0.0` : Version sémantique (si tag Git créé)
- `main-sha12345` : Version avec hash du commit

## 📊 Fonctionnalités de l'Application

- ✅ Affichage des informations du container
- ✅ Test de fonctionnalité en temps réel
- ✅ Mise à jour automatique du timestamp
- ✅ Interface responsive et moderne
- ✅ Health check automatique

## 🔐 Sécurité

- Image Alpine minimale (sécurité renforcée)
- Headers de sécurité Nginx configurés
- GZIP activé pour les performances
- Health checks réguliers

## 👨‍💻 Auteur

**Stanislas-Constantin Karim** - [GitHub](https://github.com/staniska973)

## 📝 Licence

Projet réalisé dans le cadre du TP DevSecOps - Mastère Cybersécurité & IA - EFREI

---

## 🎯 Objectifs du TP Atteints

- ✅ Conteneurisation d'une application web avec Docker
- ✅ Configuration Nginx dans un container
- ✅ Pipeline CI/CD avec GitHub Actions
- ✅ Publication automatique sur GHCR
- ✅ Versioning automatique des images
- ✅ Bonnes pratiques Docker et DevOps
