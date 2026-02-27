# TP DevSecOps - Pipeline Docker Sécurisé

[![Build and Scan](https://github.com/staniska973/devops-tp-docker/actions/workflows/docker-deploy.yml/badge.svg)](https://github.com/staniska973/devops-tp-docker/actions/workflows/docker-deploy.yml)

## 📋 Description

Application web conteneurisée avec pipeline CI/CD **sécurisé** incluant scan de vulnérabilités, analyse statique, et bonnes pratiques DevSecOps.

## 🔐 Pipeline DevSecOps

Ce projet implémente un pipeline CI/CD sécurisé avec :

### Analyse de Sécurité
- ✅ **CodeQL** - Analyse statique du code source (SAST)
- ✅ **Hadolint** - Lint du Dockerfile (bonnes pratiques)
- ✅ **Trivy** - Scan des vulnérabilités de l'image Docker
- ✅ **Dependabot** - Mise à jour automatique des dépendances
- ✅ **Secret Scanning** - Détection de secrets dans le code
- ✅ **Security Gates** - Blocage si vulnérabilités CRITICAL/HIGH
- ✅ **SBOM** - Software Bill of Materials généré automatiquement

### Architecture de Sécurité

```
Code Push
    |
    v
[Secret Scanning] --> Blocage si secret détecté
    |
    v
[Security Analysis Job]
    |
    +-- Hadolint (lint Dockerfile)
    |
    v
[Build Docker Image]
    |
    v
[Security Scan Job]
    |
    +-- Trivy (scan vulnérabilités)
    +-- Upload résultats → GitHub Security
    +-- Security Gate (fail si CRITICAL/HIGH)
    |
    v
[Push to GHCR] --> Si tous les scans passent
    |
    +-- Génération SBOM
```

## 🚀 Technologies Utilisées

- **Docker** : Conteneurisation avec image Alpine
- **Nginx Alpine** : Serveur web léger (version spécifique 1.25.3)
- **GitHub Actions** : Pipeline CI/CD automatisé
- **Trivy** : Scanner de vulnérabilités
- **Hadolint** : Linter Dockerfile
- **CodeQL** : Analyse du code source
- **GHCR** : GitHub Container Registry

## 🛡️ Sécurité de l'Image

### Améliorations TP2
- ✅ **Utilisateur non-root** : Exécution avec `appuser` (UID 1000)
- ✅ **Port non-privilégié** : 8080 au lieu de 80
- ✅ **Version spécifique** : nginx:1.25.3-alpine (pas de `latest`)
- ✅ **Headers de sécurité renforcés** : CSP, X-Frame-Options DENY, etc.
- ✅ **Méthodes HTTP limitées** : GET, HEAD, POST uniquement
- ✅ **Server tokens masqués** : Version Nginx cachée
- ✅ **Health checks** : Vérification de santé du container
- ✅ **Minimal packages** : Seulement ca-certificates installé

## 📁 Structure du Projet

```
├── .github/
│   ├── workflows/
│   │   └── docker-deploy.yml    # Pipeline CI/CD avec scans
│   └── dependabot.yml           # Configuration Dependabot
├── src/
│   ├── index.html              # Page principale
│   ├── style.css               # Styles CSS
│   └── app.js                  # Logique JavaScript
├── nginx/
│   └── nginx.conf              # Config Nginx sécurisée (port 8080)
├── Dockerfile                   # Dockerfile sécurisé (non-root)
├── .dockerignore               # Fichiers exclus du build
├── .hadolint.yaml              # Configuration Hadolint
├── package.json                # Dépendances npm (test Dependabot)
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
docker build -t devops-tp-docker:local .

# Exécuter le container (port 8080 car non-root)
docker run -d -p 8080:8080 --name devops-container devops-tp-docker:local

# Ouvrir dans le navigateur
http://localhost:8080
```

### Utiliser l'image depuis GHCR

```bash
# Télécharger et exécuter l'image publiée (sécurisée)
docker pull ghcr.io/staniska973/devops-tp-docker:latest
docker run -d -p 8080:8080 ghcr.io/staniska973/devops-tp-docker:latest
```

### Scanner l'image localement avec Trivy

```bash
# Installer Trivy (macOS)
brew install trivy

# Scanner l'image
trivy image devops-tp-docker:local

# Scanner avec seuil de sévérité
trivy image --severity HIGH,CRITICAL --exit-code 1 devops-tp-docker:local

# Générer un rapport JSON
trivy image --format json --output report.json devops-tp-docker:local
```

## 🔄 Pipeline CI/CD

Le workflow GitHub Actions se déclenche automatiquement lors de :

- **Push** sur la branche `main`
- **Création de tag** (format `v*`)
- **Pull Request** vers `main`

### Jobs du Pipeline

**1. security-analysis** (Analyse de sécurité)
- Lint du Dockerfile avec Hadolint
- Détection des mauvaises pratiques

**2. build-and-scan** (Build et scan)
- Build de l'image Docker
- Scan avec Trivy (vulnérabilités OS + packages)
- Upload des résultats dans GitHub Security
- **Security Gate** : Fail si CRITICAL ou HIGH détectés

**3. push-image** (Push si sécurité OK)
- Push vers GitHub Container Registry
- Génération du SBOM (Software Bill of Materials)
- Tagging automatique

### Actions automatiques

✅ **Si scans PASS** : Image poussée vers GHCR  
❌ **Si scans FAIL** : Pipeline bloqué, image non publiée

## 📊 Consulter les Résultats de Sécurité

1. **Code scanning alerts** : `Security` → `Code scanning`
2. **Dependabot alerts** : `Security` → `Dependabot`
3. **Secret scanning** : `Security` → `Secret scanning`
4. **Workflow logs** : `Actions` → Détails des scans Trivy

## 📦 Versions

Les images Docker sont taguées automatiquement :

- `latest` : Dernière version de la branche main (si scans OK)
- `v1.0.0` : Version sémantique (si tag Git créé)
- `main-sha12345` : Version avec hash du commit

## 📝 Métriques de Sécurité

**Indicateurs surveillés** :
- Nombre de vulnérabilités par sévérité (CRITICAL, HIGH, MEDIUM, LOW)
- Taille de l'image Docker
- Âge de l'image de base
- Temps de scan
- MTTR (Mean Time To Remediate)

## 🔑 Bonnes Pratiques Implémentées

### Dockerfile
- ✅ Image de base avec version spécifique
- ✅ Utilisateur non-root
- ✅ Instructions COPY avec --chown
- ✅ Réduction des layers
- ✅ Pas de secrets dans l'image

### Pipeline
- ✅ Scans à chaque commit
- ✅ Security gates automatiques
- ✅ SARIF upload pour GitHub Security
- ✅ SBOM généré et archivé

### Configuration Nginx
- ✅ Headers de sécurité renforcés
- ✅ Limitation des méthodes HTTP
- ✅ Masquage de la version serveur
- ✅ Content Security Policy (CSP)

## 👨‍💻 Auteur

**Stanislas-Constantin Karim** - [GitHub](https://github.com/staniska973)

## 📝 Travaux Pratiques

- ✅ **TP1** : Déploiement automatisé avec Docker et GitHub Actions
- ✅ **TP2** : Sécurisation du pipeline Docker CI/CD avec DevSecOps

**Projet réalisé dans le cadre du Mastère Cybersécurité & IA - EFREI**

---

## 🎯 Résultats TP2

### Objectifs Atteints

- ✅ Scanner des images Docker (Trivy intégré)
- ✅ Intégrer scan dans le pipeline CI/CD
- ✅ Configurer CodeQL (à activer manuellement)
- ✅ Activer Dependabot (fichier de config créé)
- ✅ Implémenter Security Gates (fail sur CRITICAL/HIGH)
- ✅ Corriger vulnérabilités (Dockerfile sécurisé + non-root)
- ✅ SBOM généré automatiquement

### Améliorations par rapport au TP1

| Aspect | TP1 | TP2 (Sécurisé) |
|--------|-----|----------------|
| Image de base | `nginx:alpine` | `nginx:1.25.3-alpine` |
| Utilisateur | root | appuser (non-root) |
| Port | 80 (privilégié) | 8080 (non-privilégié) |
| Scan vulnérabilités | ❌ Non | ✅ Trivy |
| Lint Dockerfile | ❌ Non | ✅ Hadolint |
| Security Gates | ❌ Non | ✅ Oui (CRITICAL/HIGH) |
| Headers sécurité | Basiques | Renforcés + CSP |
| SBOM | ❌ Non | ✅ Oui |
| Dependabot | ❌ Non | ✅ Oui |

---

**🔒 Security First - DevSecOps in Action**
