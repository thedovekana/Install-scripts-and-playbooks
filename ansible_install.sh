#!/bin/bash

set -e  # Arrête le script si une commande échoue

echo "#############################################"
echo "# ANSIBLE INSTALLATION SCRIPT FOR LINUX OS  #"
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
if [[ "$OS" == "centos" || "$OS" == "rhel" ]]; then
    sudo yum update -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt update -y && sudo apt upgrade -y
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

# Installation du dépôt EPEL et d'Ansible
echo "##### Installing Ansible #####"
if [[ "$OS" == "centos" || "$OS" == "rhel" ]]; then
    sudo yum install -y epel-release
    sudo yum install -y ansible
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

# Vérification de l'installation
ansible --version

echo "Ansible installation completed successfully."

