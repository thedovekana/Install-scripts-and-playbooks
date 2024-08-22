#!/bin/bash

echo "#############################################
# TOMCAT INSTALLATION & CONFIGURATION SCRIPT FOR LINUX OS #
#############################################"

# Fonction pour configurer Tomcat sur CentOS/RHEL
setup_tomcat_centos() {
    sudo yum update -y
    sudo yum install epel-release -y
    sudo yum install git zip unzip wget -y

    # Télécharger Tomcat
    TOMCAT_VERSION="10.1.15"  # Remplacez par la version souhaitée
    wget https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

    # Décompresser et installer Tomcat
    sudo tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz -C /opt
    sudo ln -s /opt/apache-tomcat-$TOMCAT_VERSION /opt/tomcat

    # Créer un utilisateur pour Tomcat
    sudo useradd -r -s /sbin/nologin tomcat
    sudo chown -R tomcat:tomcat /opt/apache-tomcat-$TOMCAT_VERSION

    # Créer un fichier de service Systemd pour Tomcat
    cat <<EOL | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

    # Recharger les fichiers de service Systemd et démarrer Tomcat
    sudo systemctl daemon-reload
    sudo systemctl start tomcat
    sudo systemctl enable tomcat
}

# Fonction pour configurer Tomcat sur Ubuntu/Debian
setup_tomcat_ubuntu() {
    sudo apt-get update -y
    sudo apt-get install -y git zip unzip wget

    # Télécharger Tomcat
    TOMCAT_VERSION="10.1.15"  # Remplacez par la version souhaitée
    wget https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

    # Décompresser et installer Tomcat
    sudo tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz -C /opt
    sudo ln -s /opt/apache-tomcat-$TOMCAT_VERSION /opt/tomcat

    # Créer un utilisateur pour Tomcat
    sudo useradd -r -s /sbin/nologin tomcat
    sudo chown -R tomcat:tomcat /opt/apache-tomcat-$TOMCAT_VERSION

    # Créer un fichier de service Systemd pour Tomcat
    cat <<EOL | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

    # Recharger les fichiers de service Systemd et démarrer Tomcat
    sudo systemctl daemon-reload
    sudo systemctl start tomcat
    sudo systemctl enable tomcat
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

# Configuration de Tomcat en fonction du système d'exploitation
case "$OS" in
    ubuntu|debian)
        setup_tomcat_ubuntu
        ;;
    centos|rhel)
        setup_tomcat_centos
        ;;
    *)
        echo "Système d'exploitation non supporté"
        exit 1
        ;;
esac

echo "Configuration terminée."


