#! /bin/bash

echo "#############################################
# ANSIBLE INSTALLATION SCRIPT FOR CENTOS OS #
#############################################"

sudo yum update -y

echo "##### Install EPEL Repository ########"

sudo yum install epel-release -y 

echo "#### Install Ansible on CentOS ####"

sudo yum install ansible -y 

ansible --version

