# Utiliser l'image de base Nginx alpine (légère et sécurisée)
FROM nginx:alpine

# Métadonnées de l'image
LABEL maintainer="DevOps Team"
LABEL description="Application DevOps containerisée avec Nginx"
LABEL version="1.0.0"

# Copier la configuration Nginx
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers de l'application web
COPY src/ /usr/share/nginx/html/

# Exposer le port 80
EXPOSE 80

# Health check - vérifie que le serveur répond correctement
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Démarrer Nginx au premier plan (important pour Docker)
CMD ["nginx", "-g", "daemon off;"]
