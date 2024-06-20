#! /bin/bash

echo "#############################################
     # DOCKER INSTALLATION SCRIPT FOR CENTOS OS   #
      #############################################"

echo "########## udpate the repo ##########"

sudo yum update -y

echo "########## Set up the repository #############"

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "########## Install Docker Engine #######"

sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "#### Manage Docker Service #####"

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
