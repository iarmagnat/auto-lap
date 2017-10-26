#!/bin/bash

# This provider updates the repositories and then installs apache2, Php7.0 and the libapache2 module that allows apache2 to run PHP files

echo "Preparing Virtual Machine ..."
sudo apt-get update > /dev/null

echo "Installing Apache2"
sudo apt-get install apache2 -y > /dev/null

echo "Installing PHP 7"
sudo apt-get install php7.0 -y > /dev/null
sudo service apache2 reload

echo "Installing libapache2-mod-php7 (required module for using php with apache)"
sudo apt-get install libapache2-mod-php7.0 -y > /dev/null
sudo service apache2 reload

