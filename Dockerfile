# Utiliser une version spécifique (pas latest) - Sécurité TP2
FROM nginx:1.29.5-alpine

# Métadonnées de l'image
LABEL maintainer="TP DevSecOps"
LABEL description="Application DevOps sécurisée avec scan de vulnérabilités"
LABEL version="2.0.0"
LABEL org.opencontainers.image.source="https://github.com/staniska973/devops-tp-docker"

# Créer un utilisateur non-root pour plus de sécurité
RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

# Installer uniquement les dépendances nécessaires
RUN apk add --no-cache \
    ca-certificates \
    && rm -rf /var/cache/apk/*

# Copier la configuration Nginx avec les bonnes permissions
COPY --chown=appuser:appgroup nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers de l'application avec les bonnes permissions
COPY --chown=appuser:appgroup src/ /usr/share/nginx/html/

# Définir les permissions appropriées
RUN chown -R appuser:appgroup /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Modifier les permissions pour que nginx puisse s'exécuter en non-root
RUN touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /etc/nginx/conf.d

# Passer à l'utilisateur non-root
USER appuser

# Exposer le port 8080 (non-privilégié, > 1024)
EXPOSE 8080

# Health check - vérifie que le serveur répond correctement
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1

# Démarrer Nginx au premier plan (important pour Docker)
CMD ["nginx", "-g", "daemon off;"]
