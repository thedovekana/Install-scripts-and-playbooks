#!/bin/bash

set -e  # Arrête le script si une commande échoue

echo "#############################################"
echo "#     DOCKER INSTALLATION SCRIPT FOR LINUX  #"
echo "#############################################"

# Détecter la distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported OS. Exiting."
    exit 1
fi

echo "########## Updating the repository ##########"

if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum update -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt update -y && sudo apt upgrade -y
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

echo "########## Setting up the Docker repository ##########"

if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/$OS/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$OS $(lsb_release -cs) stable"
    sudo apt update -y
else
    echo "Unsupported OS: $OS. Exiting."
    exit 1
fi

echo "########## Installing Docker Engine ##########"

if [[ "$OS" == "centos" || "$OS" == "rhel" || "$OS" == "fedora" ]]; then
    sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
elif [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
fi

echo "####### Managing Docker Service ########"

# Démarrer et activer Docker au démarrage
sudo systemctl start docker
sudo systemctl enable docker

# Vérifier le statut de Docker
sudo systemctl status docker

echo "Docker installation completed successfully."

