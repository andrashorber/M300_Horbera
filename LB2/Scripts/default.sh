# Default Shell Configuration for all Virtual Maschines

#!/bin/bash

# Installation of updates
sudo apt-get update
#sudo apt-get upgrade -y

# Installation and Configuration of UFW Firewall
sudo apt-get install ufw
sudo ufw default deny
sudo ufw allow 22/tcp
sudo ufw -f enable

# Installation of debconf-Utils
sudo apt-get -y install debconf-utils