#!/bin/bash

# Variables
CODE-INSIDERS-VERSION="1.84.0-1697003734"

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'

echo -e $TEXT_YELLOW
touch ~/.hushlogin
echo 'Created ~/.hushlogin...'
echo -e $TEXT_RESET

sudo apt-get update
echo -e $TEXT_YELLOW
echo 'APT update finished...'
echo -e $TEXT_RESET

sudo apt-get upgrade -y
echo -e $TEXT_YELLOW
echo 'APT upgrade finished...'
echo -e $TEXT_RESET

sudo apt-get autoremove -y
echo -e $TEXT_YELLOW
echo 'APT auto remove finished...'
echo -e $TEXT_RESET

echo -e $TEXT_YELLOW
echo 'Install OhMyZsh and Aphrodite Terminal Theme'
echo -e $TEXT_RESET
sudo apt install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --quiet https://github.com/win0err/aphrodite-terminal-theme ~/.oh-my-zsh/custom/themes/aphrodite
omz theme set aphrodite/aphrodite
omz reload
echo -e $TEXT_YELLOW
echo 'OhMyZsh and Aphrodite Terminal Theme installed...'
echo -e $TEXT_RESET

echo -e $TEXT_YELLOW
echo 'Install VS Code Insiders'
echo -e $TEXT_RESET
$ cd /tmp
$ wget https://az764295.vo.msecnd.net/insider/6a7a661757dec1983ff05ef908a2bbb75ce841e0/code-insiders_${CODE-INSIDERS-VERSION}_amd64.deb	
$ sudo dpkg -i code-insiders_${CODE-INSIDERS-VERSION}_amd64.deb

echo "alias code='_params(){ DONT_PROMPT_WSL_INSTALL=1 code-insiders "$1" > /dev/null 2>&1 &;}; _params'" >> ~/.zshrc

echo -e $TEXT_YELLOW
echo 'VS Code Insiders installed...'
echo -e $TEXT_RESET