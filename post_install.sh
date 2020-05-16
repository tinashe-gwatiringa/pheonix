#!/bin/bash

#with respect to https://github.com/waleedahmad

RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'

if [[ $EUID -ne 0 ]]; then
	echo -e "${RED}This script must be run as root${RESTORE}"
	exit 1
else
	echo -e "${GREEN}Updating and Upgrading${RESTORE}"
	sudo apt update && sudo apt upgrade -y

	echo -e "${GREEN}Installing basic utilities${RESTORE}"
	sudo apt install curl -y
	sudo apt-get install dialog

	cmd=(dialog --separate-output --checklist "Please select software you want to install:" 22 76 16)
	options=(
		1 "VS Code" on # any option can be set to default to "on"
		2 "Tilda" on
		3 "Albert" off
		4 "Htop" on
		5 "Git" on
		6 "VLC Media Player" off
		7 "Gnome Tweak Tool" off
		8 "Google Chrome" off
		9 "Skype" off
		10 "Filezilla" off
		11 "Insomnia" off
		12 "Gdebi" off
		13 "Transmission" on
		14 "Cutecom" off
		15 "Slack" off
		16 "Inkscape" off
		17 "Kicad" off
		18 "Mysql workbench (TBC)" off
		19 "Wine (Really, is that essential?)" off
		20 "Steam" off
		21 "Python and other essentials" off
		22 "Fusuma" off
		23 "GitKraken" off
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
			echo -e "${GREEN}Installing Albert${RESTORE}"
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
			echo -e "${GREEN}Installing Slack${RESTORE}"
			sudo snap install slack --classic
			;;

		16)
			echo -e "${GREEN}Installing Inkscape${RESTORE}"
			sudo apt install inkscape -y
			;;

		17)
			echo -e "${GREEN}Installing Kicad${RESTORE}"
			sudo add-apt-repository --yes ppa:js-reynaud/kicad-4
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
			sudo apt install python -y && sudo apt install python3 -y && sudo apt install python-pip -y
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
			echo -e "${GREEN}Please add to start up programs and configure later...${RESTORE}"
			;;
		23)
			echo -e "${GREEN}Installing GitKraken, please configure git later...${RESTORE}"
			wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
			sudo dpkg -i gitkraken-amd64.deb
			;;
		esac
	done
fi
