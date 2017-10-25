#!/bin/bash

	#Script pour la génération automatique du vhost

#demander le nom du site

nomSite=$(cat /transport/nomSite)
chemin=$(cat /transport/transporteur)
superPath="$chemin/$nomSite"
cd $chemin
mkdir $nomSite
touch /etc/apache2/sites-available/$nomSite.conf
cd /etc/apache2/sites-available
# ecriture du fichier de configuration
echo "<VirtualHost *:80>
        ServerAlias www.$nomSite.dev
        DocumentRoot $superPath
        <Directory />
                Options FollowSymLinks
                AllowOverride None
        </Directory>
        <Directory $superPath>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride None
                Order allow,deny
                allow from all
        </Directory>
      </VirtualHost>" >> $nomSite.conf

#activation du vhost crée
	sudo a2ensite $nomSite.conf

#relecture du fichier de configuration d'apache
	sudo service apache2 reload
#désactivation du vhost par défaut
	sudo a2dissite 000-default.conf
#relancement d'apache
	sudo service apache2 restart
