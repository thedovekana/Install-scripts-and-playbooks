#!/bin/bash


echo "#############################################
# MYSQL INSTALLATION & CONFIGURATION SCRIPT FOR LINUX OS #
#############################################"


# Fonction pour configurer et démarrer MySQL sur CentOS/RHEL
setup_mysql_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip -y

    # Ajouter le dépôt MySQL
    sudo yum localinstall https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm -y

    # Installer MySQL
    sudo yum install mysql-community-server -y

    # Démarrer et activer MySQL
    sudo systemctl start mysqld
    sudo systemctl enable mysqld

    # Initialiser MySQL (définir un mot de passe root)
    TEMP_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
    echo "Initialisation de MySQL..."
    sudo mysql_secure_installation --set-root-pass "$TEMP_PASSWORD"
}

# Fonction pour configurer et démarrer MySQL sur Ubuntu/Debian
setup_mysql_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip mysql-server

    # Démarrer et activer MySQL
    sudo systemctl start mysql
    sudo systemctl enable mysql

    # Initialiser MySQL (définir un mot de passe root)
    echo "Initialisation de MySQL..."
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

# Configuration de MySQL en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_mysql_ubuntu
        ;;
    centos|rhel)
        setup_mysql_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."

