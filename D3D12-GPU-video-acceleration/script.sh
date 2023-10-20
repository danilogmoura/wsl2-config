#!/bin/bash
RST="\e[0m" 
YEL="\e[0;33m"
RED="\e[1;31m"

CURRENT_SHELL="bash"
SHELLRC="$HOME/.bashrc"

if [[ $SHELL != *"$CURRENT_SHELL"* ]]; then
    CURRENT_SHELL=$SHELL
    SHELLRC="$HOME/.zshrc"
fi

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install binutils make perl x11-utils libx11-6 libx11-dev zlib1g zlib1g-dev tcsh -y

sudo add-apt-repository ppa:oibaf/graphics-drivers 
sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install ppa-purge -y 
sudo ppa-purge ppa:oibaf/graphics-drivers
sudo apt-get install vainfo mesa-va-drivers -y

echo "export LIBVA_DRIVER_NAME=d3d12" >> $SHELLRC

vainfo --display drm --device /dev/dri/card0

echo -e $YEL"Installation completed successfully"$RST