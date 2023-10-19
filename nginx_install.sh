#!/bin/bash

#Update the packages & install nginx

yum update
yum install nginx -y

#starting nginx service

service nginx start
service nginx enable 
service nginx restart
