#!/bin/bash
RST="\e[0m" 
YEL="\e[0;33m"
RED="\e[1;31m"

INTELLIJ_VERSION="2023.2.3"


CURRENT_SHELL="bash"
SHELLRC="$HOME/.bashrc"

if [[ $SHELL != *"$CURRENT_SHELL"* ]]; then
    CURRENT_SHELL=$SHELL
    SHELLRC="$HOME/.zshrc"
fi

touch ~/.hushlogin
echo -e $YEL"Created ~/.hushlogin..."$RST

echo -e $YEL"Update & Upgrade"$RST
sudo apt-get update -qqq -y
sudo apt-get upgrade -qqq -y

echo -e $YEL"Google Chrome"$RST
curl -fsSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/google-chrome_amd64.deb
sudo dpkg -i /tmp/google-chrome_amd64.deb 2>/dev/null
sudo apt-get install -qqq -y --fix-broken
sudo dpkg -i /tmp/google-chrome_amd64.deb 2>/dev/null
echo "alias chrome='google-chrome > /dev/null 2>&1 &'" >> $SHELLRC

echo -e $YEL"Install VS Code Insiders"$RST
curl -fsSL https://az764295.vo.msecnd.net/insider/6a7a661757dec1983ff05ef908a2bbb75ce841e0/code-insiders_1.84.0-1697003734_amd64.deb -o /tmp/code-insiders_amd64.deb
sudo dpkg -i /tmp/code-insiders_amd64.deb 2>/dev/null
sudo apt-get install -qqq -y --fix-broken
sudo dpkg -i /tmp/code-insiders_amd64.deb 2>/dev/null
echo "alias code='_params(){ DONT_PROMPT_WSL_INSTALL=1 code-insiders \"\$1\" > /dev/null 2>&1 &}; _params'" >> $SHELLRC

echo -e $YEL"Install Node Version Manager (https://github.com/nvm-sh/nvm)"$RST
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm --version

echo -e $YEL"Install IntelliJ IDEA (https://www.jetbrains.com/idea/download/?section=linux)"$RST
curl -fsSL https://download-cdn.jetbrains.com/idea/ideaIU-${INTELLIJ_VERSION}.tar.gz -o /tmp/idea-IU.tar.gz
sudo tar xvfz /tmp/idea-IU.tar.gz -C /opt --transform 's!^[^/]*!idea-IU!'
echo "alias intellij='/opt/idea-IU/bin/idea.sh > /dev/null 2>&1 &'" >> $SHELLRC

echo -e $YEL"Install Docker"$RST
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qqq
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -qqq -y

sudo apt-get autoremove -y

sudo usermod -aG docker $USER
newgrp docker