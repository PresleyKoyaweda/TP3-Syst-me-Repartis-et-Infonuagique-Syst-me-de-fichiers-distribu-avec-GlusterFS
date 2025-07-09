# Utiliser Ubuntu Focal comme image de base
FROM ubuntu:focal

# Eviter les prompts de l'interface utilisateur lors de l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Mise à jour des paquets et installation de GlusterFS
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:gluster/glusterfs-9 && \
    apt-get update && \
    apt-get install -y glusterfs-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Exposer les ports pour GlusterFS
# 24007 pour le daemon de gestion, 49152-49160 pour les briques
EXPOSE 24007 49152-49160

# Commande pour démarrer le daemon GlusterFS
CMD ["glusterd", "-N"]
