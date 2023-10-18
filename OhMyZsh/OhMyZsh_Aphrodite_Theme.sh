#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'

echo -e $TEXT_YELLOW
echo 'Install OhMyZsh and Aphrodite Terminal Theme'
echo -e $TEXT_RESET
sudo apt install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --quiet https://github.com/win0err/aphrodite-terminal-theme ~/.oh-my-zsh/custom/themes/aphrodite
omz theme set aphrodite/aphrodite
omz reload