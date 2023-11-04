#! /bin/bash

echo "#############################################
     # DOCKER INSTALLATION SCRIPT FOR CENTOS OS   #
      #############################################"

sudo yum update -y

echo "#### Install the Dependencies #####"

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

echo "##### Add the Docker Repository to CentOS #####"

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "#### Install Docker On CentOS Using Yum ####"

sudo yum install docker -y 

echo "#### Manage Docker Service #####"

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
