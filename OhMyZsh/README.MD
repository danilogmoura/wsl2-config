## OhMyZsh

## Install OhMyZsh (Optional) (https://github.com/ohmyzsh/ohmyzsh) ##
$ sudo apt install zsh -y
$ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	## Aphrodite Terminal Theme (https://github.com/win0err/aphrodite-terminal-theme)
	$ git clone --quiet https://github.com/win0err/aphrodite-terminal-theme ~/.oh-my-zsh/custom/themes/aphrodite
	$ omz theme set aphrodite/aphrodite
	$ omz reload