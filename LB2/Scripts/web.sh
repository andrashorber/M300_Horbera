# Default Shell Configuration for all Webserver Virtual Maschines

#!/bin/bash

# Installation of required packets
sudo apt-get install -y apache2 php mysql-client php-mysql

# Installation and Configuration of Wordpress
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chown vagrant wp-cli.phar
chmod 761 wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
sudo rm /var/www/html/index.html
mkdir /var/www/html/M300
sudo chown vagrant /var/www/html/M300
sudo chmod 761 /var/www/html/M300
sudo -u vagrant -i wp core download --path=/var/www/html/M300
sudo -u vagrant -i wp core config --dbhost=192.168.255.20 --dbname="wordpress" --dbuser="wpuser" --dbpass="P4ssw0rd!" --dbprefix="wp_" --path=/var/www/html/M300
chmod 777 /var/www/html/M300/wp-config.php
sudo -u vagrant -i wp core install --url="192.168.0.52" --title="M300_LB2" --admin_user="M300_Admin" --admin_password="P4ssw0rd!" --admin_email="admin@localhost.ch" --path=/var/www/html/M300
sudo sed -i s!/var/www/html!/var/www/html/M300! /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart

# Configuration of Wordpress Site
sudo -u vagrant -i wp plugin update --path=/var/www/html/M300 --all
sudo -u vagrant -i wp theme update --path=/var/www/html/M300 --all

# Configuration of UFW Firewall
sudo ufw allow 80/tcp
sudo ufw reload