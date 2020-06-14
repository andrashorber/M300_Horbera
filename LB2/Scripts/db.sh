# Default Shell Configuration for all Database Virtual Maschines

#!/bin/bash

# Setting of root password, so installation can go on
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password S0m3-R4nd0m-P4ssw0rd!'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password S0m3-R4nd0m-P4ssw0rd!'

# Installation of required packets
sudo apt-get install -y mysql-server

# Configuration of mysql-server
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart

# Creating Mysql User and Database
sudo mysql -uroot -pS0m3-R4nd0m-P4ssw0rd! <<%EOF%
create database if not exists wordpress;
create user "wpuser" identified by "P4ssw0rd!";
create user "wpuser"@"192.168.255.30" identified by "P4ssw0rd!";
grant usage on wordpress.* to "wpuser" identified by "P4ssw0rd!";
grant usage on wordpress.* to "wpuser"@"192.168.255.30" identified by "P4ssw0rd!";
grant all privileges on wordpress.* to "wpuser";
grant all privileges on wordpress.* to "wpuser"@"192.168.255.30";
flush privileges;
%EOF%

# Configuration of UFW Firewall
sudo ufw allow 3306/tcp
sudo ufw reload
