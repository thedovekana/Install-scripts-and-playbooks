#! /bin/bash


echo "#############################################
# JENKINS INSTALLATION SCRIPT FOR REDHAT OS #
#############################################"

sudo yum update -y

echo "####### Add Jenkins Repository ######"

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

echo "###### Import the Jenkins Repository GPG Key ######"


sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key


echo "#######  Add required dependencies for the jenkins package ########"


#amazon-linux-extras install java-openjdk11 -y  ### for Amazon Linux system

sudo yum install java-11-openjdk -y ### for others redhat systems


echo "######## Install jenkins ##########"


sudo yum install jenkins -y 


sudo systemctl daemon-reload

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo systemctl status jenkins


