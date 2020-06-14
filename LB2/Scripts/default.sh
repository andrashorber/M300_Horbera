# Default Shell Configuration for all Virtual Maschines

#!/bin/bash

# Installation of updates
sudo apt-get update
sudo apt-get upgrade -y

# Installation and Configuration of UFW Firewall
sudo apt-get install ufw
sudo ufw default deny
sudo ufw allow from 10.0.0.0/8 to any port 22
sudo ufw -f enable
