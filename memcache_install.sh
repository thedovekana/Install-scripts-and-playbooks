#!/bin/bash

set -e  # Arrête le script si une commande échoue

echo "#############################################"
echo "#  MEMCACHED INSTALLATION SCRIPT FOR LINUX  #"
echo "#############################################"

# Détecter la distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported OS. Exiting."
    exit 1
fi

echo "########## Installing EPEL repository ##########"

if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum install epel-release -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt update -y
    sudo apt install software-properties-common -y
    sudo add-apt-repository universe -y
    sudo apt update -y
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

echo "########## Installing Memcached ##########"

if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum install memcached -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt install memcached -y
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

echo "########## Managing Memcached Service ##########"

# Démarrer et activer Memcached au démarrage
sudo systemctl start memcached
sudo systemctl enable memcached

# Vérifier le statut de Memcached
sudo systemctl status memcached

echo "Memcached installation completed successfully."

