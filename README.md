### Terminal ###
Download and Install stable version
https://github.com/microsoft/terminal


## PowerShell ##
https://github.com/PowerShell/PowerShell


### WSL ###
Download and Install latast version
https://github.com/microsoft/WSL


### Installing Ubuntu on WSL ###
PS > wsl --list --verbose
PS > wsl --list --online
PS > wsl --install Ubuntu-22.04


### WSL Configuration ###
touch ~/.hushlogin
$ sudo apt update
$ sudo apt upgrade -y

# Change ubuntu WSL2 Hostname permanently (Optional)
$ sudo vim /etc/wsl.conf

	[network]
	hostname = demo-host
	generateHosts = false

$ sudo vim /etc/hosts

	# [network]
	# generateHosts = false
	127.0.0.1	localhost
	127.0.1.1	demo-host.	demo-host

$ sudo vim /etc/hostname	(update the old host name to your desired hostname)

	demo-host

$ exit
PS > wsl --terminate Ubuntu-22.04


## Install OhMyZsh (Optional) (https://github.com/ohmyzsh/ohmyzsh) ##
$ sudo apt install zsh -y
$ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	## Aphrodite Terminal Theme (https://github.com/win0err/aphrodite-terminal-theme)
	$ git clone --quiet https://github.com/win0err/aphrodite-terminal-theme ~/.oh-my-zsh/custom/themes/aphrodite
	$ omz theme set aphrodite/aphrodite
	$ omz reload


## Install Docker ##
# Uninstall old versions
$ for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Install using the Apt repository
# Add Docker's official GPG key:
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl gnupg
$ sudo install -m 0755 -d /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
$ echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Manage Docker as a non-root user
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
$ newgrp docker
$ docker run hello-world


## Node Version Manager (https://github.com/nvm-sh/nvm) ##
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
$ export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
$ nvm --version


## Simple Python Version Management: pyenv (https://github.com/pyenv/pyenv) ##
$ curl https://pyenv.run | bash

## Google Chrome ##
$ cd /tmp
$ sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
$ sudo dpkg -i google-chrome-stable_current_amd64.deb 
$ sudo apt install --fix-broken -y
$ sudo dpkg -i google-chrome-stable_current_amd64.deb

alias chrome="google-chrome > /dev/null 2>&1 &"


## VS Code (https://code.visualstudio.com/download#) ##
$ cd /tmp
$ wget https://az764295.vo.msecnd.net/insider/6a7a661757dec1983ff05ef908a2bbb75ce841e0/code-insiders_1.84.0-1697003734_amd64.deb	
$ sudo dpkg -i code-insiders_1.84.0-1697003734_amd64.deb

alias code='_params(){ DONT_PROMPT_WSL_INSTALL=1 code-insiders "$1" > /dev/null 2>&1 &}; _params'


## IntelliJ IDEA (https://www.jetbrains.com/idea/download/?section=linux) ## 
$ wget https://download-cdn.jetbrains.com/idea/ideaIU-2023.2.3.tar.gz
$ sudo tar -xzf ideaIU-2023.2.3.tar.gz -C /opt

alias intellij="/opt/idea-IU-232.10072.27/bin/idea.sh > /dev/null 2>&1 &"


## DataGrip (https://www.jetbrains.com/datagrip/download/#section=linux) ##
$ wget https://download-cdn.jetbrains.com/datagrip/datagrip-2023.2.2.tar.gz
$ sudo tar -xzf datagrip-2023.2.2.tar.gz -C /opt

alias intellij="/opt/DataGrip-2023.2.2/bin/datagrip.sh > /dev/null 2>&1 &"

## GIT SSH (https://github.com/settings/keys) ## 
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
$ ssh -T git@github.com

## Postman (https://www.postman.com/downloads/) ##
$ cd /tmp
$ wget https://dl.pstmn.io/download/latest/linux_64 -O pstmn.tar.gz
$ sudo tar -xzf pstmn.tar.gz -C /opt

alias postman="/opt/Postman/Postman > /dev/null 2>&1 &"

