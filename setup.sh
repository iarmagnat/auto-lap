#!/bin/bash
sudo apt-get update > /dev/null
echo "Prepare Virtual Machine ..."
sudo apt-get update > /dev/null

echo "Installing Git"
sudo apt-get install git -y > /dev/null

echo "Installing Apache2"
sudo apt-get install apache2 -y > /dev/null

echo "Updating PHP repository"


reponse=$(cat /transport/php)
if [ "$reponse" = "5" ]
  then

  echo "Install PHP 5"
  sudo apt-get install php.0 -y > /dev/null
  sudo service apache2 reload

  echo "Install libapache2-mod-php5"
  sudo apt-get install libapache2-mod-php5 -y > /dev/null

else

echo "Install PHP 7"
sudo apt-get install php7.0 -y > /dev/null
sudo service apache2 reload

echo "libapache2-mod-php7"
sudo apt-get install libapache2-mod-php7.0 -y > /dev/null
sudo service apache2 reload

fi

source /transport/vHostScript.bash
