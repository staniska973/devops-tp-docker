# 📦 GUIDE DE RENDU - TP1 & TP2 DevSecOps

**Étudiant** : Stanislas-Constantin Karim  
**Repository** : https://github.com/staniska973/devops-tp-docker  
**Date** : 27 février 2026

---

## 🎯 SYNTHÈSE DES TPs

### ✅ TP1 - Déploiement Automatisé (VALIDÉ)
**Objectif** : Conteneurisation et pipeline CI/CD basique  
**Statut** : ✅ Terminé et fonctionnel  
**Commits** :
- `85d1cb8` : Initial commit avec Docker + CI/CD
- `2079386` : Fix CSS + README (tag v1.0.0)

### ✅ TP2 - Sécurisation Pipeline (EN COURS)
**Objectif** : DevSecOps avec scan de vulnérabilités  
**Statut** : 🔄 Code pushé, étapes manuelles à finaliser  
**Commit** :
- `addd966` : Ajout Trivy, Hadolint, Dockerfile sécurisé

---

## 📂 STRUCTURE DU REPOSITORY

```
devops-tp-docker/
├── .github/
│   ├── workflows/
│   │   └── docker-deploy.yml      # TP2: Pipeline avec Trivy + Hadolint
│   └── dependabot.yml             # TP2: Config Dependabot
├── nginx/
│   └── nginx.conf                 # TP2: Port 8080 + headers sécurité renforcés
├── src/
│   ├── index.html                 # TP1: Application web
│   ├── style.css                  # TP1: CSS (corrigé)
│   └── app.js                     # TP1: JavaScript
├── Dockerfile                      # TP2: Utilisateur non-root + version spécifique
├── .dockerignore                  # TP1: Exclusions build
├── .hadolint.yaml                 # TP2: Config lint Dockerfile
├── package.json                   # TP2: Test Dependabot
├── README.md                      # TP2: Documentation complète
└── GUIDE_TP2.md                   # TP2: Guide étape par étape
```

---

## 🔍 COMMENT VÉRIFIER LE TP1 (PROF)

Le TP1 est **INTACT** et **FONCTIONNEL** malgré les ajouts du TP2.

### Historique Git préservé
```bash
git log --oneline
# 85d1cb8 : Initial commit TP1 ✅
# 2079386 : Fix CSS TP1 (tag v1.0.0) ✅
# addd966 : Ajout TP2 (nouveaux fichiers) ✅
```

### Vérifier le TP1 à un instant T
```bash
# Consulter l'état au moment du TP1
git checkout 2079386

# Revenir à la version actuelle (TP1 + TP2)
git checkout main
```

### Fonctionnalités TP1 toujours présentes
- ✅ Application web HTML/CSS/JS
- ✅ Conteneurisation Docker avec Nginx
- ✅ Pipeline GitHub Actions
- ✅ Publication GHCR
- ✅ Tag v1.0.0
- ✅ README initial

**Les modifications TP2 sont des AMÉLIORATIONS, pas des remplacements !**

---

## 🔐 CE QUI A ÉTÉ FAIT (TP2)

### ✅ Fichiers créés (nouveaux, n'existaient pas dans TP1)
1. `.github/dependabot.yml` - Surveillance dépendances
2. `.hadolint.yaml` - Configuration lint Dockerfile
3. `package.json` - Dépendances npm (test)
4. `GUIDE_TP2.md` - Documentation TP2

### ✅ Fichiers modifiés (améliorés pour sécurité)
1. **Dockerfile** 
   - Avant (TP1) : `FROM nginx:alpine`, utilisateur root, port 80
   - Après (TP2) : `FROM nginx:1.25.3-alpine`, utilisateur appuser, port 8080

2. **nginx/nginx.conf**
   - Avant (TP1) : Port 80, headers basiques
   - Après (TP2) : Port 8080, headers CSP, limitation méthodes HTTP

3. **.github/workflows/docker-deploy.yml**
   - Avant (TP1) : Build + Push simple
   - Après (TP2) : 3 jobs (Hadolint → Trivy scan → Push + SBOM)

4. **README.md**
   - Avant (TP1) : Documentation basique
   - Après (TP2) : Documentation DevSecOps complète + badges

### ✅ Améliorations de sécurité
- ✅ Utilisateur non-root (appuser:appgroup)
- ✅ Port non-privilégié (8080 au lieu de 80)
- ✅ Version spécifique nginx (1.25.3-alpine)
- ✅ Scan Trivy intégré au pipeline
- ✅ Hadolint pour lint Dockerfile
- ✅ Security Gates (fail si CRITICAL/HIGH)
- ✅ SBOM généré automatiquement
- ✅ Headers de sécurité renforcés (CSP)

---

## 📋 CHECKLIST RENDU FINAL

### ✅ Déjà fait (automatisé)
- [x] Code TP1 poussé sur GitHub
- [x] Tag v1.0.0 créé
- [x] Code TP2 poussé sur GitHub
- [x] Workflow GitHub Actions configuré
- [x] README complet avec documentation
- [x] GUIDE_TP2.md créé
- [x] Dockerfile sécurisé (non-root)
- [x] Nginx configuré pour port 8080
- [x] Dependabot configuré
- [x] Hadolint configuré

### 🔴 À FAIRE MANUELLEMENT (étapes GitHub)

#### 1. Activer CodeQL (2 minutes) - OBLIGATOIRE TP2
```
1. https://github.com/staniska973/devops-tp-docker
2. Onglet "Security" → "Code scanning"
3. "Set up code scanning" → "CodeQL Analysis"
4. Cliquer "Configure"
5. Ne rien modifier, cliquer "Commit changes"
```
**Résultat** : Fichier `.github/workflows/codeql-analysis.yml` créé automatiquement

#### 2. Activer Secret Scanning (1 minute) - OBLIGATOIRE TP2
```
1. https://github.com/staniska973/devops-tp-docker/settings
2. "Code security and analysis"
3. Activer "Secret scanning" → Enable
4. Activer "Push protection" → Enable
```
**Résultat** : Protection contre les secrets dans le code

#### 3. Vérifier le workflow (3-5 min) - VALIDATION
```
1. https://github.com/staniska973/devops-tp-docker/actions
2. Observer le workflow "Build, Scan and Push Docker Image"
3. Vérifier que les 3 jobs s'exécutent :
   - security-analysis (Hadolint) → ✅ doit être vert
   - build-and-scan (Trivy) → ⚠️ peut échouer si vulnérabilités
   - push-image (Push GHCR) → ✅ si scan OK
```

#### 4. Consulter les alertes de sécurité
```
1. https://github.com/staniska973/devops-tp-docker/security
2. "Code scanning" → Voir les résultats Trivy
3. Noter les vulnérabilités détectées
```

#### 5. Corriger les vulnérabilités (si le pipeline échoue)

**Si des vulnérabilités CRITICAL/HIGH sont détectées** :

```bash
# Option 1 : Mettre à jour l'image de base
# Modifier Dockerfile ligne 2
FROM nginx:1.25.4-alpine  # ou version plus récente

# Option 2 : Accepter les PR Dependabot
# Aller dans "Pull requests" et merger les PR

# Option 3 : Mettre à jour package.json
# Versions recommandées :
{
  "dependencies": {
    "express": "^4.18.2",
    "lodash": "^4.17.21"
  },
  "devDependencies": {
    "eslint": "^8.55.0"
  }
}

# Puis commit et push
git add .
git commit -m "Fix: Update dependencies to resolve vulnerabilities"
git push origin main
```

---

## 📸 PREUVES À FOURNIR (SCREENSHOTS)

Pour le rendu final, préparez ces captures d'écran :

### TP1
1. ✅ Application web fonctionnelle (http://localhost:8080)
2. ✅ Workflow GitHub Actions vert
3. ✅ Image Docker sur GHCR
4. ✅ Tag v1.0.0 visible

### TP2
1. 🔴 Dashboard Security avec alertes Trivy
2. 🔴 Workflow "Build, Scan and Push" avec 3 jobs
3. 🔴 CodeQL activé (onglet Security)
4. 🔴 Secret Scanning activé (Settings)
5. 🔴 Dependabot PR (si générées)
6. 🔴 SBOM téléchargé (Artifacts dans Actions)
7. 🔴 Container en exécution sur port 8080

---

## 🧪 TESTS DE VALIDATION

### Tester l'image TP1 (version initiale)
```powershell
# Checkout version TP1
git checkout 2079386

# Build
docker build -t devops-tp1:test .

# Run (port 80 en TP1)
docker run -d -p 8080:80 --name tp1-test devops-tp1:test

# Test
# http://localhost:8080

# Cleanup
docker stop tp1-test
docker rm tp1-test

# Revenir à main
git checkout main
```

### Tester l'image TP2 (version sécurisée)
```powershell
# Build version TP2
docker build -t devops-tp2:test .

# Run (port 8080 en TP2, non-root)
docker run -d -p 8080:8080 --name tp2-test devops-tp2:test

# Test
# http://localhost:8080

# Vérifier l'utilisateur non-root
docker exec tp2-test whoami
# Doit afficher : appuser

# Vérifier le port
docker exec tp2-test netstat -tlnp
# Doit afficher : 0.0.0.0:8080

# Cleanup
docker stop tp2-test
docker rm tp2-test
```

### Scanner avec Trivy localement
```powershell
# Installer Trivy
# https://github.com/aquasecurity/trivy/releases

# Scanner l'image
trivy image devops-tp2:test

# Scanner avec seuil
trivy image --severity HIGH,CRITICAL devops-tp2:test
```

---

## 📄 DOCUMENTS À RENDRE

### Fichiers du repository (déjà sur GitHub)
- ✅ Tout le code source
- ✅ README.md complet
- ✅ GUIDE_TP2.md (ce fichier)
- ✅ Historique Git complet

### Documents complémentaires à préparer
1. **Rapport PDF** (optionnel selon consignes)
   - Présentation du projet
   - Architecture du pipeline
   - Résultats des scans
   - Screenshots
   - Difficultés rencontrées
   - Améliorations TP2

2. **Screenshots** (dans un dossier ou PDF)
   - Application fonctionnelle
   - Workflows GitHub Actions
   - Alertes de sécurité
   - Configuration activée

3. **Lien du repository**
   ```
   https://github.com/staniska973/devops-tp-docker
   ```

---

## ⚠️ IMPORTANT POUR LE PROF

### Le TP1 est-il toujours consultable ?
**OUI !** Le TP1 est intact et consultable de deux manières :

**Méthode 1 : Via les commits**
```bash
git checkout 2079386  # État TP1 complet
git checkout main     # État TP1 + TP2
```

**Méthode 2 : Via le tag**
```bash
git checkout v1.0.0   # Version TP1 finale
git checkout main     # Version actuelle
```

**Méthode 3 : Via l'historique GitHub**
Sur GitHub, cliquer sur "commits", puis sur `2079386` pour voir l'état TP1.

### Différences TP1 vs TP2 (résumé)
| Élément | TP1 | TP2 |
|---------|-----|-----|
| Utilisateur Docker | root | appuser (non-root) |
| Port | 80 | 8080 |
| Image de base | nginx:alpine | nginx:1.25.3-alpine |
| Scan sécurité | ❌ Non | ✅ Trivy |
| Lint Dockerfile | ❌ Non | ✅ Hadolint |
| Security Gates | ❌ Non | ✅ Oui |
| SBOM | ❌ Non | ✅ Oui |

---

## 🚀 ORDRE D'EXÉCUTION POUR FINALISER

1. ✅ **FAIT** : Code pushé sur GitHub
2. 🔴 **À FAIRE** : Activer CodeQL (2 min)
3. 🔴 **À FAIRE** : Activer Secret Scanning (1 min)
4. 🔴 **À FAIRE** : Observer le workflow Actions (5 min)
5. 🔴 **À FAIRE** : Corriger vulnérabilités si nécessaire (10-30 min)
6. 🔴 **À FAIRE** : Prendre screenshots (5 min)
7. 🔴 **À FAIRE** : Tester localement (optionnel, 10 min)
8. 🔴 **À FAIRE** : Préparer rendu final (20 min)

---

## 📞 LIENS UTILES

- **Repository** : https://github.com/staniska973/devops-tp-docker
- **Actions** : https://github.com/staniska973/devops-tp-docker/actions
- **Security** : https://github.com/staniska973/devops-tp-docker/security
- **Settings** : https://github.com/staniska973/devops-tp-docker/settings
- **Packages** : https://github.com/staniska973?tab=packages

---

## ✅ VALIDATION FINALE

**Le TP est considéré terminé quand** :
- [x] Code TP1 + TP2 sur GitHub
- [ ] CodeQL activé et fonctionnel
- [ ] Secret Scanning activé
- [ ] Workflow avec 3 jobs tous verts ✅
- [ ] Aucune vulnérabilité CRITICAL/HIGH
- [ ] Screenshots pris
- [ ] Documentation complète

**Temps estimé pour finaliser : 30-60 minutes**

---

**Bon courage ! 🎓🔒**
