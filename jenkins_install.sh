#!/bin/bash

set -e  # Arrête le script si une commande échoue

echo "#############################################"
echo "# JENKINS INSTALLATION SCRIPT FOR LINUX OS  #"
echo "#############################################"

# Détecter la distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported OS. Exiting."
    exit 1
fi

# Mise à jour des paquets existants
echo "##### Updating system packages #####"
if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum update -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt update -y && sudo apt upgrade -y
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

echo "####### Adding Jenkins Repository ######"

# Télécharger le fichier repo Jenkins
JENKINS_REPO_URL="https://pkg.jenkins.io/redhat-stable/jenkins.repo"
if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo curl -fsSL $JENKINS_REPO_URL -o /etc/yum.repos.d/jenkins.repo || sudo wget -O /etc/yum.repos.d/jenkins.repo $JENKINS_REPO_URL
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update -y
fi

echo "####### Installing Java ######"

# Installer Java selon la distribution
if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum install java-17-openjdk -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt install openjdk-17-jdk -y
fi

echo "####### Installing Jenkins ######"

# Installer Jenkins selon la distribution
if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum install jenkins -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt install jenkins -y
fi

echo "####### Starting and Enabling Jenkins ######"

# Démarrer et activer Jenkins au démarrage
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Vérifier le statut de Jenkins
sudo systemctl status jenkins

echo "Jenkins installation completed successfully."

