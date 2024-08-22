#!/bin/bash

echo "#############################################
# MARIADB INSTALLATION & CONFIGURATION SCRIPT  #
#############################################"


# Fonction pour configurer et démarrer MariaDB sur CentOS/RHEL
setup_mariadb_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip -y
    sudo yum install mariadb-server -y

    # Démarrer et activer MariaDB
    sudo systemctl start mariadb
    sudo systemctl enable mariadb

    # Initialiser MariaDB (définir un mot de passe root et sécuriser l'installation)
    sudo mysql_secure_installation
}

# Fonction pour configurer et démarrer MariaDB sur Ubuntu/Debian
setup_mariadb_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip mariadb-server

    # Démarrer et activer MariaDB
    sudo systemctl start mariadb
    sudo systemctl enable mariadb

    # Initialiser MariaDB (définir un mot de passe root et sécuriser l'installation)
    sudo mysql_secure_installation
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

# Configuration de MariaDB en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_mariadb_ubuntu
        ;;
    centos|rhel)
        setup_mariadb_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."

