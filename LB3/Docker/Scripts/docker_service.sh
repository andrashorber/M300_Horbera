#!/bin/bash

#Monitoring of Docker service
#By András Horber
#06.07.2020 - V1

#check
SERVICE="docker"
stat=$(systemctl is-active $SERVICE)
if [ "$stat" = "active" ]
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped"
    echo "$SERVICE service stopped running on Host 192.168.123.20" | ssmtp andispam@gmx.ch
fi