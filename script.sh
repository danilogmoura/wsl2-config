#!/bin/bash
TEXT_RESET="\e[0m" 
TEXT_YELLOW="\e[0;33m"
TEXT_RED_B="\e[1;31m"

CURRENT_SHELL="bash"
SHELLRC="$HOME/.bashrc"

if [[ $SHELL != *"$CURRENT_SHELL"* ]]; then
    CURRENT_SHELL=$SHELL
    SHELLRC="$HOME/.zshrc"
fi

echo -e $TEXT_YELLOW
touch ~/.hushlogin
echo "Created ~/.hushlogin..."
echo -e $TEXT_RESET

sudo apt-get update
echo -e $TEXT_YELLOW
echo "APT update finished..."
echo -e $TEXT_RESET

sudo apt-get upgrade -y
echo -e $TEXT_YELLOW
echo "APT upgrade finished..."
echo -e $TEXT_RESET

sudo apt install curl -y
echo -e $TEXT_YELLOW
echo "CURL installed..."
echo -e $TEXT_RESET

echo -e $TEXT_YELLOW
echo "Install VS Code Insiders"
echo -e $TEXT_RESET
CODE_VERSION="1.84.0-1697003734"
CODE_URL="https://az764295.vo.msecnd.net/insider/6a7a661757dec1983ff05ef908a2bbb75ce841e0/code-insiders_${CODE_VERSION}_amd64.deb"
CODE="/tmp/code-insiders_amd64.deb"
curl -L  $CODE_URL --output $CODE
sudo dpkg -i $CODE
sudo apt install --fix-broken -y
sudo dpkg -i $CODE
echo "alias code='_params(){ DONT_PROMPT_WSL_INSTALL=1 code-insiders \"\$1\" > /dev/null 2>&1 &}; _params'" >> $SHELLRC
echo -e $TEXT_YELLOW
echo "VS Code Insiders installed..."
echo -e $TEXT_RESET

echo -e $TEXT_YELLOW
echo "Install Simple Python Version Management (pyenv)"
echo -e $TEXT_RESET
curl https://pyenv.run | bash
export PYENV_ROOT="$HOME/.pyenv"
echo "export PYENV_ROOT=\"$HOME/.pyenv\"" >> $SHELLRC
echo -e $TEXT_YELLOW
echo "PYENV installed..."
echo -e $TEXT_RESET

sudo apt-get autoremove -y
echo -e $TEXT_YELLOW
echo "APT auto remove finished..."
echo -e $TEXT_RESET