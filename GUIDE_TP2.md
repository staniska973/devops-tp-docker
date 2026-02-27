# 🔐 GUIDE TP2 - SÉCURISATION DOCKER

## ✅ CE QUI A ÉTÉ AUTOMATISÉ (100%)

### Fichiers créés :
1. ✅ `.github/dependabot.yml` - Configuration Dependabot
2. ✅ `.hadolint.yaml` - Configuration Hadolint
3. ✅ `package.json` - Dépendances npm (test)

### Fichiers modifiés :
4. ✅ `Dockerfile` → Version sécurisée :
   - Utilisateur non-root (appuser)
   - Port 8080 au lieu de 80
   - Version spécifique nginx:1.25.3-alpine
   - Permissions correctes

5. ✅ `nginx/nginx.conf` → Sécurité renforcée :
   - Port 8080 pour non-root
   - Headers CSP + X-Frame-Options DENY
   - Limitation méthodes HTTP
   - Server tokens masqués

6. ✅ `.github/workflows/docker-deploy.yml` → Pipeline DevSecOps :
   - Job 1: Hadolint (lint Dockerfile)
   - Job 2: Build + Trivy scan + Security Gates
   - Job 3: Push (si scans OK) + SBOM

7. ✅ `README.md` → Documentation complète TP2

---

## 🚀 ÉTAPES À SUIVRE MAINTENANT

### ÉTAPE 1 : Pusher les changements TP2
```powershell
cd "C:\Users\stani\OneDrive - Efrei\Bureau\DIVERS\EFREI\Mastère Cyber & IA\1ER SEM\DevSecOps\TP1_Deployment\devops-tp-docker"

git add .
git commit -m "TP2: Add DevSecOps pipeline with Trivy, Hadolint, secure Dockerfile"
git push origin main
```

### ÉTAPE 2 : Activer CodeQL (MANUEL - 2 min) 🔴
**OBLIGATOIRE** : GitHub ne peut pas créer ce fichier automatiquement via push.

1. Allez sur : https://github.com/staniska973/devops-tp-docker
2. Cliquez sur l'onglet **"Security"**
3. Cliquez sur **"Code scanning"** (dans le menu gauche)
4. Cliquez sur **"Set up code scanning"**
5. Recherchez **"CodeQL Analysis"** → Cliquez sur **"Configure"**
6. GitHub va créer `.github/workflows/codeql-analysis.yml`
7. **Ne modifiez rien**, cliquez directement sur **"Commit changes"**

✅ CodeQL sera alors activé et analysera votre code JavaScript.

### ÉTAPE 3 : Activer Secret Scanning (MANUEL - 1 min) 🔴
1. Allez sur : https://github.com/staniska973/devops-tp-docker/settings
2. Cliquez sur **"Code security and analysis"**
3. Activez :
   - ✅ **"Secret scanning"** → Enable
   - ✅ **"Push protection"** → Enable (recommandé)

✅ Les secrets seront détectés et bloqués lors du push.

### ÉTAPE 4 : Observer le pipeline (3-5 min)
1. Allez dans l'onglet **"Actions"**
2. Vous verrez le workflow **"Build, Scan and Push Docker Image"**
3. 3 jobs doivent s'exécuter :
   - ✅ `security-analysis` (Hadolint)
   - ✅ `build-and-scan` (Trivy + Security Gates)
   - ✅ `push-image` (Push GHCR + SBOM)

**ATTENTION** : Le job `build-and-scan` peut ÉCHOUER si des vulnérabilités CRITICAL/HIGH sont détectées. C'est **NORMAL** ! C'est le Security Gate en action. 🔒

### ÉTAPE 5 : Analyser les résultats de sécurité
1. Allez dans **"Security"** → **"Code scanning alerts"**
2. Vous verrez les vulnérabilités Trivy détectées
3. Pour chaque alerte :
   - Cliquez pour voir les détails
   - Notez le CVE
   - Vérifiez la sévérité (CRITICAL, HIGH, MEDIUM, LOW)

### ÉTAPE 6 : Corriger les vulnérabilités (si nécessaire)

**Si le pipeline ÉCHOUE à cause de vulnérabilités** :

#### Option 1 : Mettre à jour l'image de base
```dockerfile
# Dans Dockerfile, remplacez la version
FROM nginx:1.25.4-alpine  # ou version plus récente
```

#### Option 2 : Accepter les PR Dependabot
1. Allez dans **"Pull requests"**
2. Vous verrez des PR créées automatiquement par Dependabot
3. Analysez et mergez chaque PR

#### Option 3 : Mettre à jour package.json
```json
{
  "dependencies": {
    "express": "^4.18.2",  // version corrigée
    "lodash": "^4.17.21"   // version corrigée
  },
  "devDependencies": {
    "eslint": "^8.55.0"    // version corrigée
  }
}
```

Puis :
```powershell
git add package.json
git commit -m "Fix: Update dependencies to resolve vulnerabilities"
git push origin main
```

### ÉTAPE 7 : Tester l'image localement (OPTIONNEL)
```powershell
# Pull l'image depuis GHCR
docker pull ghcr.io/staniska973/devops-tp-docker:latest

# Run sur port 8080 (non-root)
docker run -d -p 8080:8080 --name devops-secure ghcr.io/staniska973/devops-tp-docker:latest

# Tester dans le navigateur
# http://localhost:8080
```

### ÉTAPE 8 : Scanner localement avec Trivy (OPTIONNEL)
```powershell
# Installer Trivy (Windows)
# Télécharger depuis : https://github.com/aquasecurity/trivy/releases

# Scanner l'image
trivy image ghcr.io/staniska973/devops-tp-docker:latest

# Scanner avec seuil
trivy image --severity HIGH,CRITICAL ghcr.io/staniska973/devops-tp-docker:latest
```

---

## 📊 RÉSULTATS ATTENDUS DU TP2

### ✅ Pipeline DevSecOps complet
- Hadolint vérifie le Dockerfile
- Trivy scanne l'image Docker
- Security Gates bloquent si vulnérabilités critiques
- SBOM généré automatiquement

### ✅ Image Docker sécurisée
- Utilisateur non-root (appuser)
- Port non-privilégié (8080)
- Version spécifique de l'image de base
- Headers de sécurité renforcés
- Pas de vulnérabilités CRITICAL/HIGH (après corrections)

### ✅ Outils de sécurité activés
- CodeQL pour l'analyse du code
- Dependabot pour les dépendances
- Secret Scanning pour détecter les secrets
- Dashboard Security complet

### ✅ Visibilité totale
- Alertes de sécurité dans GitHub Security
- Badges dans README
- SBOM disponible en artefact
- Logs détaillés dans Actions

---

## 🎯 CHECKLIST FINALE TP2

- [ ] Tous les fichiers poussés sur GitHub
- [ ] CodeQL activé manuellement
- [ ] Secret Scanning activé manuellement  
- [ ] Workflow "Build, Scan and Push" exécuté
- [ ] Les 3 jobs (security-analysis, build-and-scan, push-image) sont verts ✅
- [ ] Aucune alerte CRITICAL/HIGH dans Security
- [ ] Image Docker poussée sur GHCR
- [ ] SBOM généré et téléchargeable
- [ ] README à jour avec badges

---

## ❓ TROUBLESHOOTING

### ❌ Le job `build-and-scan` échoue
**Cause** : Vulnérabilités CRITICAL ou HIGH détectées par Trivy.  
**Solution** : Consultez Security → Code scanning alerts et corrigez les vulnérabilités.

### ❌ Le container ne démarre pas (port 8080)
**Cause** : Conflit de port ou mauvaise configuration nginx.  
**Solution** : 
```powershell
docker logs devops-secure
docker port devops-secure
```

### ❌ CodeQL ne se lance pas
**Cause** : Pas activé manuellement.  
**Solution** : Suivez l'étape 2 ci-dessus.

### ❌ Dependabot ne crée pas de PR
**Cause** : Fichier `.github/dependabot.yml` mal formaté.  
**Solution** : Vérifiez le fichier avec un validateur YAML.

---

## 📚 COMMANDES UTILES

```powershell
# Voir les logs du container
docker logs devops-secure

# Inspecter l'image
docker inspect ghcr.io/staniska973/devops-tp-docker:latest

# Lister les vulnérabilités
trivy image --severity HIGH,CRITICAL ghcr.io/staniska973/devops-tp-docker:latest

# Générer un rapport JSON
trivy image --format json --output report.json ghcr.io/staniska973/devops-tp-docker:latest

# Vérifier le Dockerfile localement
docker run --rm -i hadolint/hadolint < Dockerfile
```

---

## 🏆 FÉLICITATIONS !

Vous avez implémenté un pipeline DevSecOps complet avec :
- ✅ Scan de vulnérabilités automatique
- ✅ Security Gates
- ✅ Image Docker sécurisée (non-root)
- ✅ Bonnes pratiques DevSecOps

**Passez à l'action maintenant ! 🚀**
