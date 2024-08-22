#!/bin/bash

echo "#############################################
# NGINX INSTALLATION SCRIPT FOR LINUX OS #
#############################################"


# Fonction pour configurer et démarrer Nginx sur CentOS/RHEL
setup_nginx_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip -y
    sudo yum install nginx -y

    # Démarrer et activer Nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Optionnel : configurer Nginx (par exemple, copier des fichiers de configuration personnalisés)
    # sudo cp /path/to/your/nginx.conf /etc/nginx/nginx.conf
}

# Fonction pour configurer et démarrer Nginx sur Ubuntu/Debian
setup_nginx_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip nginx

    # Démarrer et activer Nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Optionnel : configurer Nginx (par exemple, copier des fichiers de configuration personnalisés)
    # sudo cp /path/to/your/nginx.conf /etc/nginx/nginx.conf
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

# Configuration de Nginx en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_nginx_ubuntu
        ;;
    centos|rhel)
        setup_nginx_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."

