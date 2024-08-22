#!/bin/bash

echo "#############################################
# HAPROXY INSTALLATION SCRIPT FOR LINUX OS #
#############################################"


# Fonction pour configurer HAProxy sur CentOS/RHEL
setup_haproxy_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip wget -y

    # Installer HAProxy
    sudo yum install haproxy -y

    # Créer un fichier de configuration HAProxy (exemple simple)
    cat <<EOL | sudo tee /etc/haproxy/haproxy.cfg
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    option  httplog
    option  dontlognull
    timeout connect 5000ms
    timeout client  50000ms
    timeout server  50000ms

frontend http_front
    bind *:80
    default_backend http_back

backend http_back
    server server1 127.0.0.1:8080 check
EOL

    # Démarrer et activer HAProxy
    sudo systemctl start haproxy
    sudo systemctl enable haproxy
}

# Fonction pour configurer HAProxy sur Ubuntu/Debian
setup_haproxy_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip wget

    # Installer HAProxy
    sudo apt-get install haproxy -y

    # Créer un fichier de configuration HAProxy (exemple simple)
    cat <<EOL | sudo tee /etc/haproxy/haproxy.cfg
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    option  httplog
    option  dontlognull
    timeout connect 5000ms
    timeout client  50000ms
    timeout server  50000ms

frontend http_front
    bind *:80
    default_backend http_back

backend http_back
    server server1 127.0.0.1:8080 check
EOL

    # Démarrer et activer HAProxy
    sudo systemctl start haproxy
    sudo systemctl enable haproxy
}

# Fonction pour détecter le système d'exploitation
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    elif [ -f /etc/redhat-release ]; then
        OS="centos"
    else
        echo "Système d'exploitation non supporté"
        exit 1
    fi
}

# Détection du système d'exploitation
detect_os

# Configuration de HAProxy en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_haproxy_ubuntu
        ;;
    centos|rhel)
        setup_haproxy_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."

