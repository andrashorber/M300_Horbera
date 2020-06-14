# Default Shell Configuration for Proxy Virtual Maschine

#!/bin/bash

# Installation of required packets
sudo apt-get install -y haproxy

# Insert Settings for haproxy Websites
printf '\nfrontend main-site\n  bind *:80\n  use_backend public\n' | dd conv=notrunc oflag=append bs=1 of=/etc/haproxy/haproxy.cfg
printf '\nbackend public\n  balance roundrobin\n  server web01 192.168.255.30:80 check\n  server web02 192.168.255.31:80 check\n' | dd conv=notrunc oflag=append bs=1 of=/etc/haproxy/haproxy.cfg
sudo systemctl reload haproxy

# Configuration of UFW Firewall
sudo ufw allow 80/tcp
sudo ufw reload