#!/bin/bash

echo "#############################################
# APACHE INSTALLATION SCRIPT FOR LINUX OS #
#############################################"



# Fonction pour configurer et démarrer Apache sur CentOS/RHEL
setup_apache_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip -y
    sudo yum install httpd -y

    # Démarrer et activer Apache
    sudo systemctl start httpd
    sudo systemctl enable httpd

    # Optionnel : configurer Apache (par exemple, copier des fichiers de configuration personnalisés)
    # sudo cp /path/to/your/httpd.conf /etc/httpd/conf/httpd.conf
}

# Fonction pour configurer et démarrer Apache sur Ubuntu/Debian
setup_apache_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip apache2

    # Démarrer et activer Apache
    sudo systemctl start apache2
    sudo systemctl enable apache2

    # Optionnel : configurer Apache (par exemple, copier des fichiers de configuration personnalisés)
    # sudo cp /path/to/your/apache2.conf /etc/apache2/apache2.conf
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

# Configuration d'Apache en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_apache_ubuntu
        ;;
    centos|rhel)
        setup_apache_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."

