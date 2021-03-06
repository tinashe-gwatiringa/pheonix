#!/bin/bash

#with respect to https://github.com/waleedahmad

RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'

TEMP_DIR='tmp'

function get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

if [[ $EUID -ne 0 ]]; then
	echo -e "${RED}This script must be run as root${RESTORE}"
	exit 1
else
	mkdir TEMP_DIR
	echo -e "${GREEN}Updating and upgrading${RESTORE}"
	sudo apt update && sudo apt upgrade -y

	echo -e "${GREEN}Installing basic utilities${RESTORE}"
	sudo apt install curl -y
	sudo apt-get install dialog

	cmd=(dialog --separate-output --checklist "Please select software you want to install:" 22 76 16)
	options=(
		1 "VS Code" off # any option can be set to default to "on"
		2 "Tilda" off
		3 "Albert" off
		4 "Htop" off
		5 "Git" off
		6 "VLC Media Player" off
		7 "Gnome Tweak Tool" off
		8 "Google Chrome" off
		9 "Skype" off
		10 "Filezilla" off
		11 "Insomnia" off
		12 "Gdebi" off
		13 "Transmission" off
		14 "Cutecom" off
		15 "Polybar" off
		16 "Inkscape" off
		17 "Kicad" off
		18 "Mysql workbench (TBC)" off
		19 "Wine (Really, is that essential?)" off
		20 "Steam" off
		21 "Python and other essentials" off
		22 "Fusuma" off
		23 "GitKraken" off
		24 "Slack" off
		25 "Spotify" off
		26 "Development tools (JavaScript, Docker, aws)" off
		27 "Fish terminal emulator" off
	)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in
		1)
			echo -e "${GREEN}Installing VS Code${RESTORE}"
			echo -e "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
			curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
			sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
			sudo apt-get update
			sudo apt-get install code -y
			;;

		2)
			echo -e "${GREEN}Installing Tilda${RESTORE}"
			sudo apt install tilda -y
			;;
		3)
			echo -e "${GREEN}Installing Python${RESTORE}"
			sudo apt install python -y && sudo apt install python3 -y && sudo apt install python-pip -y
			
			;;

		4)
			echo -e "${GREEN}Installing Htop${RESTORE}"
			sudo apt install htop -y
			;;

		5)
			echo -e "${GREEN}Installing Git, please congiure git later...${RESTORE}"
			apt install git -y
			;;

		6)
			echo -e "${GREEN}Installing VLC Media Player${RESTORE}"
			apt install vlc -y
			;;
		7)
			echo -e "${GREEN}Installing Gnome Tweak Tool${RESTORE}"
			apt install gnome-tweak-tool -y
			;;
		8)
			echo -e "${GREEN}Installing Google Chrome${RESTORE}"
			wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
			sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
			apt-get update
			apt-get install google-chrome-stable -y
			;;

		9)
			echo -e "${GREEN}Installing Skype For Linux${RESTORE}"
			apt install apt-transport-https -y
			curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
			echo -e "deb https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list
			apt update
			apt install skypeforlinux -y
			;;

		10)
			echo -e "${GREEN}Installing Filezilla${RESTORE}"
			sudo apt install filezilla -y
			;;

		11)
			echo -e "${GREEN}Installing Insomnia${RESTORE}"
			echo -e "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
			# Add public key used to verify code signature
			wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
			# Refresh repository sources and install Insomnia
			sudo apt update -y
			sudo apt install insomnia -y
			;;

		12)
			echo -e "${GREEN}Installing Gdebi${RESTORE}"
			sudo apt install gdebi -y
			;;

		13)
			echo -e "${GREEN}Installing Transmission${RESTORE}"
			sudo apt install transmission -y
			;;

		14)
			echo -e "${GREEN}Installing Cutecom${RESTORE}"
			sudo apt install cutecom -y
			;;

		15)
			echo -e "${GREEN}Installing Polybar${RESTORE}"
			VERSION=get_latest_release "polybar/polybar"
			wget -P $TEMP_FOLDER -q "https://github.com/polybar/polybar/releases/download/$VERSION/polybar-$VERSION.tar"
			
			WORKING_DIR=pwd
			cd $TEMP_DIR
			tar -xvf polybar-$VERSION.tar
			cd $polybar-$VERSION
			./build
			
			cd $WORKING_DIR
			;;

		16)
			echo -e "${GREEN}Installing Inkscape${RESTORE}"
			sudo apt install inkscape -y
			;;

		17)
			echo -e "${GREEN}Installing Kicad${RESTORE}"
			sudo add-apt-repository --yes ppa:js-reynaud/kicad-5-nightly
			sudo apt-get update
			sudo apt-get install kicad -y
			;;

		18)
			echo -e "${GREEN}Installing MySQLWorkbench${RESTORE}"
			# mysql-workbench-community-6.3.10-1ubuntu17.10-amd64
			echo -e "${RED}still need to work out the way to install 4.2.6${RESTORE}"
			;;

		19)
			echo -e "${GREEN}Installing Wine${RESTORE}"
			sudo dpkg --add-architecture i386
			wget -nc https://dl.winehq.org/wine-builds/winehq.key
			sudo apt-key add winehq.key
			sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
			sudo apt install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 -y
			sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport
			sudo apt update
			sudo apt upgrade -y
			sudo apt install --install-recommends winehq-stable -y
			;;

		20)
			echo -e "${GREEN}Installing Steam${RESTORE}"
			sudo apt install steam-installer -y
			steam
			;;

		21)
			echo -e "${GREEN}Installing Python and others${RESTORE}"
			sudo apt install libffi-dev python-setuptools -y
			sudo ldconfig
			sudo pip3 install virtualenv
			sudo -u ${USER} curl https://pyenv.run | bash
			echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
			echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
			echo 'eval "$(pyenv init -)"' >>~/.bashrc
			echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc

			sudo apt install python3 -y
			sudo apt install python3-pip -y

			# Installing in root, need to work on this
			sudo -u ${USER} curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
			;;

		22)
			echo -e "${GREEN}Installing Fusuma, please configure later...${RESTORE}"
			# From https://github.com/iberianpig/fusuma
			sudo gpasswd -a $USER input
			sudo apt install libinput-tools -y
			sudo apt install xdotool -y
			sudo apt install ruby -y
			sudo gem i fusuma
			gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled

			mkdir -p ~/.config/fusuma
			cp configurations/fusuma/config.yml ~/.config/fusuma/.
			sudo gpasswd -a $USER input
			echo -e "${GREEN}Please add to start up programs and configure later...${RESTORE}"
			;;
		23)
			echo -e "${GREEN}Installing GitKraken, please configure git later...${RESTORE}"
			wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
			sudo dpkg -i gitkraken-amd64.deb
			;;
		24)
			echo -e "${GREEN}Installing Slack${RESTORE}"
			wget -P $TEMP_DIR https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb
			sudo apt install ./$TEMP_DIR/slack-desktop-*.deb -y
			;;
		25)
			echo -e "${GREEN}Installing Spotify${RESTORE}"
			curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
			echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
			sudo apt install spotify-client -y
			;;
		26)
			echo -e "${GREEN}Installing development tools${RESTORE}"
			sudo apt install npm -y
			wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
			echo -e "${GREEN}Installing Docker${RESTORE}"
			sudo apt install docker docker-compose -y
			sudo groupadd docker
			sudo usermod -aG docker ${USER}
			echo -e "${YELLOW}Logout required${RESTORE}"
			echo -e "${GREEN}Installing awscli${RESTORE}"
			sudo apt install awscli -y
			curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$TEMP_DIR/awscliv2.zip"
			unzip $TEMP_DIR/awscliv2.zip -d $TEMP_DIR/
			sudo ./$TEMP_DIR/aws/install
			;;
		27)
			echo -e "${GREEN}Installing terminal tools${RESTORE}"
			sudo apt-add-repository ppa:fish-shell/release-3 -y
			sudo apt-get update -y
			sudo apt-get install fish -y
			sudo chsh -s /usr/bin/fish
			set -U fish_greeting ""

			sudo apt install mate-terminal -y
			echo -e "${GREEN}Select mate-terminal as the default${RESTORE}"
			sudo update-alternatives --config x-terminal-emulator
			;;

		28)
			echo -e "${GREEN}Installing pycharm${RESTORE}"
			wget -qO- https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
			echo -e "${YELLOW}Complete installation using jetbrains-toolbox${RESTORE}"
			;;

		esac

	done
fi

echo -e "${GREEN}Running final update${RESTORE}"
sudo apt update && sudo apt upgrade && sudo apt autoclean -y
echo -e "${GREEN}Cleaning up${RESTORE}"
sudo rm -r $TEMP_DIR