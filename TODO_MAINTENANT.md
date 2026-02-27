# ⚡ ACTION IMMÉDIATE - 3 ÉTAPES À FAIRE MAINTENANT

**Tout le code est pushé ! Il reste 3 actions MANUELLES sur GitHub.**

---

## 🔴 ÉTAPE 1 : ACTIVER CODEQL (2 min)

**Pourquoi ?** GitHub ne peut pas créer ce fichier automatiquement via push. C'est une config security obligatoire.

### Marche à suivre :
1. **Ouvrez** : https://github.com/staniska973/devops-tp-docker
2. **Cliquez** sur l'onglet **"Security"** (🛡️ en haut)
3. **Cliquez** sur **"Code scanning"** (menu gauche)
4. **Cliquez** sur **"Set up code scanning"**
5. Trouvez **"CodeQL Analysis"** → **Cliquez sur "Configure"**
6. GitHub ouvre un éditeur avec le fichier `.github/workflows/codeql-analysis.yml`
7. **NE MODIFIEZ RIEN** → Cliquez directement sur **"Commit changes..."**
8. Cliquez sur **"Commit changes"** (bouton vert)

✅ **Résultat attendu** : Fichier `.github/workflows/codeql-analysis.yml` créé

---

## 🔴 ÉTAPE 2 : ACTIVER SECRET SCANNING (1 min)

**Pourquoi ?** Protection contre les secrets (tokens, clés API) dans le code.

### Marche à suivre :
1. **Ouvrez** : https://github.com/staniska973/devops-tp-docker/settings
2. **Cliquez** sur **"Code security and analysis"** (menu gauche)
3. Trouvez la section **"Secret scanning"**
4. **Cliquez sur "Enable"** (bouton)
5. Trouvez la section **"Push protection"**
6. **Cliquez sur "Enable"** (bouton)

✅ **Résultat attendu** : 
- ✅ Secret scanning : Enabled
- ✅ Push protection : Enabled

---

## 🔴 ÉTAPE 3 : OBSERVER LE WORKFLOW (3-5 min)

**Pourquoi ?** Vérifier que le pipeline DevSecOps fonctionne avec Trivy + Hadolint.

### Marche à suivre :
1. **Ouvrez** : https://github.com/staniska973/devops-tp-docker/actions
2. **Cherchez** le workflow nommé **"Build, Scan and Push Docker Image"**
3. **Cliquez** dessus pour voir les détails
4. **Observez** les 3 jobs :
   - 🟢 **security-analysis** : Lint Dockerfile avec Hadolint
   - 🟡/🔴 **build-and-scan** : Build + scan Trivy (peut échouer si vulnérabilités)
   - 🟢 **push-image** : Push GHCR + SBOM (ne s'exécute que si scan OK)

### Cas possibles :

#### ✅ CAS 1 : Tous les jobs sont VERTS
**Bravo !** Le pipeline est sécurisé, aucune vulnérabilité critique.
→ **Passez directement aux screenshots**

#### ❌ CAS 2 : Le job "build-and-scan" est ROUGE
**Normal !** C'est le Security Gate qui bloque car des vulnérabilités CRITICAL/HIGH ont été détectées.

**Actions à faire** :
1. Cliquez sur le job rouge **"build-and-scan"**
2. Cliquez sur l'étape **"Run Trivy with fail on CRITICAL/HIGH"**
3. Notez les vulnérabilités affichées (CVE-xxxx)
4. Allez dans **Security** → **"Code scanning alerts"** pour voir les détails

**Comment corriger ?** Voir [CORRECTION_VULNERABILITES.md](#correction)

---

## 📸 ÉTAPE 4 : PRENDRE LES SCREENSHOTS (5 min)

Une fois les 3 étapes ci-dessus faites, prenez ces captures d'écran pour le rendu :

### Screenshots obligatoires :
1. ✅ **Application web** : http://localhost:8080 (si vous l'avez lancée)
2. ✅ **GitHub Actions** : Page du workflow avec les 3 jobs visibles
3. ✅ **Security > Code scanning** : Dashboard avec résultats Trivy
4. ✅ **Security > Code scanning** : CodeQL activé et lancé
5. ✅ **Settings > Security** : Secret Scanning + Push Protection activés
6. ✅ **Repository** : README visible avec documentation complète

### Screenshots bonus (si temps) :
7. Terminal : `docker run` avec l'image
8. Terminal : `docker exec <container> whoami` → affiche "appuser"
9. GitHub Packages : Image publiée sur GHCR
10. Actions > Workflow : SBOM téléchargé dans Artifacts

---

## 🛠️ CORRECTION VULNÉRABILITÉS {#correction}

**Si le workflow échoue à cause de vulnérabilités**, voici les solutions :

### Solution 1 : Mettre à jour l'image de base (RECOMMANDÉ)

```powershell
cd "C:\Users\stani\OneDrive - Efrei\Bureau\DIVERS\EFREI\Mastère Cyber & IA\1ER SEM\DevSecOps\TP1_Deployment\devops-tp-docker"

# Ouvrir Dockerfile et modifier la ligne 2
# Remplacer : FROM nginx:1.25.3-alpine
# Par :       FROM nginx:1.25.4-alpine
# (ou version plus récente disponible)

git add Dockerfile
git commit -m "Fix: Update nginx to latest version to resolve CVE"
git push origin main
```

### Solution 2 : Accepter les PR Dependabot

1. Allez dans **Pull requests**
2. Si Dependabot a créé des PR → Cliquez dessus
3. Vérifiez les changements
4. Cliquez sur **"Merge pull request"**

### Solution 3 : Mettre à jour package.json

```powershell
# Ouvrir package.json et remplacer par :
{
  "name": "devops-tp-docker",
  "version": "1.0.1",
  "description": "TP DevSecOps avec Docker et sécurisation",
  "scripts": {
    "test": "echo \"No tests yet\""
  },
  "dependencies": {
    "express": "^4.18.2",
    "lodash": "^4.17.21"
  },
  "devDependencies": {
    "eslint": "^8.55.0"
  }
}

# Puis push
git add package.json
git commit -m "Fix: Update npm dependencies to resolve vulnerabilities"
git push origin main
```

### Solution 4 : Ignorer temporairement (DÉCONSEILLÉ)

**Seulement si** vous ne trouvez pas de correctif et pour débloquer le TP :

```yaml
# Dans .github/workflows/docker-deploy.yml
# Modifier l'étape "Run Trivy with fail on CRITICAL/HIGH"
- name: Run Trivy with fail on CRITICAL/HIGH
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: ${{ env.IMAGE_NAME }}:scan
    exit-code: '0'  # ← Changer de '1' à '0' pour ne pas bloquer
    ignore-unfixed: true
    severity: 'CRITICAL,HIGH'
```

⚠️ **Attention** : Cette solution n'est PAS recommandée car elle désactive le Security Gate !

---

## ⏱️ RÉCAPITULATIF TEMPS

- ✅ ÉTAPE 1 (CodeQL) : 2 minutes
- ✅ ÉTAPE 2 (Secret Scanning) : 1 minute
- ✅ ÉTAPE 3 (Observer workflow) : 3-5 minutes
- ⚠️ CORRECTION (si nécessaire) : 10-30 minutes
- ✅ ÉTAPE 4 (Screenshots) : 5 minutes

**TOTAL : 15-45 minutes selon si corrections nécessaires**

---

## ✅ CHECKLIST FINALE

Avant de soumettre le rendu, vérifiez :

- [ ] CodeQL activé (Security → Code scanning)
- [ ] Secret Scanning activé (Settings → Security)
- [ ] Workflow GitHub Actions avec 3 jobs
- [ ] Les 3 jobs sont VERTS ✅ (ou corrections appliquées)
- [ ] Screenshots pris (minimum 6)
- [ ] README.md à jour sur GitHub
- [ ] GUIDE_TP2.md disponible sur GitHub
- [ ] RENDU_FINAL.md disponible sur GitHub
- [ ] Historique Git complet visible (TP1 + TP2)
- [ ] Tag v1.0.0 présent (TP1)

---

## 🎯 LIEN À FOURNIR AU PROF

```
https://github.com/staniska973/devops-tp-docker
```

**Tout est dans le repository !**

---

## 🆘 BESOIN D'AIDE ?

### Le workflow ne se lance pas
→ Vérifiez que le fichier `.github/workflows/docker-deploy.yml` existe  
→ Allez dans Actions et cliquez sur "Enable workflows"

### CodeQL ne s'active pas
→ Assurez-vous d'avoir bien cliqué sur "Commit changes"  
→ Rafraîchissez la page Security

### Le container ne démarre pas
→ Vérifiez les logs : `docker logs <container_name>`  
→ Vérifiez le port : `docker ps` (doit montrer 8080)

### Trivy trouve trop de vulnérabilités
→ Mettez à jour l'image de base vers la dernière version stable  
→ Consultez Security → Code scanning pour voir les détails

---

**C'EST PARTI ! 🚀**

**COMMENCEZ PAR L'ÉTAPE 1 MAINTENANT ⬆️**
