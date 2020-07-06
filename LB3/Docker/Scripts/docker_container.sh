#!/bin/bash

#Monitoring of Docker Container
#By András Horber
#06.07.2020 - V1

#check
SERVICE="docker_cadvisor_run_975d0728faf5"
if [ "$(docker ps -q -f name="^/$SERVICE" -f status=running)" ]
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped"
    echo "$SERVICE container stopped running on Host 192.168.123.20" | ssmtp andispam@gmx.ch
fi

SERVICE="docker_wordpress_run_456755a91e75"
if [ "$(docker ps -q -f name="^/$SERVICE" -f status=running)" ]
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped"
    echo "$SERVICE container stopped running on Host 192.168.123.20" | ssmtp andispam@gmx.ch
fi

SERVICE="db01"
if [ "$(docker ps -q -f name="^/$SERVICE" -f status=running)" ]
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped"
    echo "$SERVICE container stopped running on Host 192.168.123.20" | ssmtp andispam@gmx.ch
fi
