#!/bin/bash

default_user="demo"
host_name="demo-host"
host_in_file="$(grep -m 1 -n $(hostname) /etc/hosts | cut -f1 -d:)"

if [ ! -z "$host_in_file" ] 
then  
sudo echo "
[network]
hostname = ${host_name}
generateHosts = false

[user]
default= ${default_user} " >> /etc/wsl.conf
  
sudo sed -i "${host_in_file}s/$(hostname)/${host_name}/g" /etc/hosts
  
sudo echo "${host_name}" > /etc/hostname
fi