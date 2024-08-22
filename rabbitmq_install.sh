#!/bin/bash

echo "#############################################
# RABBITMQ INSTALLATION SCRIPT FOR LINUX OS #
#############################################"



# Fonction pour configurer RabbitMQ sur CentOS/RHEL
setup_rabbitmq_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip wget -y

    # Installer Erlang (dépendance de RabbitMQ)
    sudo yum install https://github.com/erlang/otp/releases/download/OTP-24.0.1/erlang-24.0.1-1.el8.x86_64.rpm -y

    # Installer RabbitMQ
    sudo tee /etc/yum.repos.d/rabbitmq.repo <<EOL
[rabbitmq]
name=RabbitMQ Repository
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/24/el/8/x86_64/
gpgcheck=1
gpgkey=https://dl.bintray.com/rabbitmq/keys/rabbitmq-release-signing-key.asc
enabled=1
EOL

    sudo yum install rabbitmq-server -y

    # Démarrer et activer RabbitMQ
    sudo systemctl start rabbitmq-server
    sudo systemctl enable rabbitmq-server

    # Activer le plugin de gestion web (optionnel)
    sudo rabbitmq-plugins enable rabbitmq_management
}

# Fonction pour configurer RabbitMQ sur Ubuntu/Debian
setup_rabbitmq_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip wget

    # Installer Erlang (dépendance de RabbitMQ)
    sudo apt-get install -y erlang

    # Ajouter le dépôt RabbitMQ
    echo "deb https://dl.bintray.com/rabbitmq/debian focal main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
    wget -O - https://dl.bintray.com/rabbitmq/keys/rabbitmq-release-signing-key.asc | sudo apt-key add -

    # Installer RabbitMQ
    sudo apt-get update -y
    sudo apt-get install -y rabbitmq-server

    # Démarrer et activer RabbitMQ
    sudo systemctl start rabbitmq-server
    sudo systemctl enable rabbitmq-server

    # Activer le plugin de gestion web (optionnel)
    sudo rabbitmq-plugins enable rabbitmq_management
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

# Configuration de RabbitMQ en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_rabbitmq_ubuntu
        ;;
    centos|rhel)
        setup_rabbitmq_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."

