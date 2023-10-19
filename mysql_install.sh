#!/bin/bash

sudo yum update -y
sudo yum install epel-release -y
sudo yum install git zip unzip -y
sudo yum install mariadb-server -y

# starting & enabling mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
