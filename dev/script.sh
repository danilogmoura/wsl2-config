#!/bin/bash
RST="\e[0m" 
YEL="\e[0;33m"
RED="\e[1;31m"

default_user="demo"
host_name="demo-host"

# https://www.jetbrains.com/idea/download/?section=linux
INTELLIJ_VERSION="2023.2.3"
# https://www.jetbrains.com/datagrip/download/#section=linux
DATAGRIP_VERSION="2023.2.2"
# https://github.com/nvm-sh/nvm
NVM_VERSION="v0.39.5"

CURRENT_SHELL="bash"
SHELLRC="$HOME/.bashrc"

if [[ $SHELL != *"$CURRENT_SHELL"* ]]; then
    CURRENT_SHELL=$SHELL
    SHELLRC="$HOME/.zshrc"
fi

touch ~/.hushlogin

echo -e $YEL"Update & Upgrade"$RST
sudo apt-get update -q
sudo apt-get upgrade -qq -y

echo -e $YEL"Google Chrome"$RST
curl -fsSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/google-chrome_amd64.deb
sudo dpkg -i /tmp/google-chrome_amd64.deb 2>/dev/null
sudo apt-get install -qq -y --fix-broken
sudo dpkg -i /tmp/google-chrome_amd64.deb 2>/dev/null
echo "alias chrome='google-chrome > /dev/null 2>&1 &'" >> $SHELLRC

echo -e $YEL"Install VS Code Insiders"$RST
curl -fsSL https://az764295.vo.msecnd.net/insider/6a7a661757dec1983ff05ef908a2bbb75ce841e0/code-insiders_1.84.0-1697003734_amd64.deb -o /tmp/code-insiders_amd64.deb
sudo dpkg -i /tmp/code-insiders_amd64.deb 2>/dev/null
sudo apt-get install -qq -y --fix-broken
sudo dpkg -i /tmp/code-insiders_amd64.deb 2>/dev/null
echo "alias code='_params(){ DONT_PROMPT_WSL_INSTALL=1 code-insiders \"\$1\" > /dev/null 2>&1 &}; _params'" >> $SHELLRC

echo -e $YEL"Install Node Version Manager"$RST
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm --version

echo -e $YEL"Install Postman"$RST
curl -fsSL https://dl.pstmn.io/download/latest/linux_64 -o /tmp/postman.tar.gz
sudo tar xvfz /tmp/postman.tar.gz -C /opt
echo "alias postman='/opt/Postman/Postman > /dev/null 2>&1 &'" >> $SHELLRC

echo -e $YEL"Install IntelliJ IDEA"$RST
curl -fsSL https://download-cdn.jetbrains.com/idea/ideaIU-${INTELLIJ_VERSION}.tar.gz -o /tmp/intellij.tar.gz
sudo tar xvfz /tmp/intellij.tar.gz -C /opt --transform 's!^[^/]*!Intellij!'
echo "alias intellij='/opt/Intellij/bin/idea.sh > /dev/null 2>&1 &'" >> $SHELLRC

echo -e $YEL"Install DataGrip"$RST
curl -fsSL https://download-cdn.jetbrains.com/datagrip/datagrip-${DATAGRIP_VERSION}.tar.gz -o /tmp/datagrip.tar.gz
sudo tar xvfz /tmp/datagrip.tar.gz -C /opt --transform 's!^[^/]*!DataGrip!'
echo "alias datagrip='/opt/DataGrip/bin/datagrip.sh > /dev/null 2>&1 &'" >> $SHELLRC

echo -e $YEL"Install Docker"$RST
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -q
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -qqq -y
sudo usermod -aG docker $USER

sudo apt-get autoremove -qq -y

echo -e $YEL"Rename host name"$RST
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

echo -e $YEL"Installation completed successfully"$RST