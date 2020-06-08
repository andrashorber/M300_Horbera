# Default Shell Configuration for all Webserver Virtual Maschines

#!/bin/bash

# Installation of required packets
sudo apt-get install -y apache2 php mysql-client php-mysql

# Installation and Configuration of Wordpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html/
sudo rm index.html
sudo chown vagrant /var/www/html
su vagrant
wp core download
wp core config --dbhost=192.168.255.20 --dbname="wordpress" --dbuser="wpuser" --dbpass="P4ssw0rd!" --dbprefix="m300_"
chmod 644 wp-config.php
#wp core install --url="localhost" --title="M300_LB2" --admin_user="M300_Admin" --admin_password="P4ssw0rd!" --admin_email="admin@localhost.ch"

# Management of Site

# Configuration of UFW Firewall
sudo ufw allow 80/tcp
sudo ufw reload