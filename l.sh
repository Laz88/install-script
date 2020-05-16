#!/bin/bash

##########################
# README FOR NEW USERS   #
##########################
#
#	Run this command:
# 	bash <(wget -O - https://raw.githubusercontent.com/Laz88/install-script/master/l.sh)
#
##########################
# SCRIPT BEGINS HERE     #
##########################

# Step 0: verify the user is not root (or else the script will fail)

if [ "$USER" == root ]; then
	echo "[USER check] = Failed"
	echo "Error -- this script cannot be executed with sudo. Try ./ instead."
	echo "Exiting..."
	exit
else
	echo "[USER check] = $USER"
fi

sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install mysql-server -y
sudo apt-get install php libapache2-mod-php
sudo apt-get install php7.4-zip -y
sudo apt-get install php7.4-mbstring -y
sudo apt-get install php7.4-dom -y
sudo apt-get install php7.4-mysql

sudo touch /var/www/html/info.php
sudo chmod 777 /var/www/html/info.php
sudo echo '<?php' >> /var/www/html/info.php
sudo echo 'phpinfo();' >> /var/www/html/info.php
sudo echo '?>' >> /var/www/html/info.php

sudo systemctl restart apache2*


php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/local/bin/composer

composer global require laravel/installer

sudo echo 'export PATH="/home/'$USER'/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc

echo "Enjoy your Laravel."
