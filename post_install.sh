#!/bin/bash


#with respect to https://github.com/waleedahmad

RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'


if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	#echo "Updating and Upgrading"
	#sudo apt update && sudo apt upgrade -y
	#sudo apt install curl -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "VS Code" off    # any option can be set to default to "on"
	         2 "guake" off
	         3 "python and other essentials" off
	         4 "Gitkraken" off
	         5 "Git" off
			 6 "VLC Media Player" off
	         7 "Gnome Tweak Tool" off
	         8 "Google Chrome" off
	         9 "Skype" off
	   		 10	"Filezilla" off
			 11 "Insomnia" off
			 12 "gdebi" off
			 13 "transmission" off
			 14 "cutecom" off
			 15 "slack" off
			 16 "gimp" off
			 17 "kicad" off
			 18 "mysql workbench (TBC)" off
			 19 "wine (Really, is that essential?)" off
			 20 "dash-to-dock" off
			 21 "Steam" off
			 22 "Hamatchi Server" off

			)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            echo "Installing VS Code"
				echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vs-code.list
				curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
				sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
				sudo apt-get update
				sudo apt-get install code -y
				;;

			2)
			    echo "Installing guake"
				sudo apt install guake -y	
				;;
    		3)	
				echo "Installing Python and Others"
				sudo apt install python -y && sudo apt install python3 -y && sudo apt install python-pip -y
				;;
				
			4)
				echo "Installing GitKraken, please congiure git later..."
				wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
				sudo dpkg -i gitkraken-amd64.deb
				;;

			5)
				echo "Installing Git, please congiure git later..."
				apt install git -y
				;;
			
			6)
				echo "Installing VLC Media Player"
				apt install vlc -y
				;;
			7)
				echo "Installing Gnome Tweak Tool"
				apt install gnome-tweak-tool -y
				;;
			8)
				echo "Installing Google Chrome"
				wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
				sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
				apt-get update 
				apt-get install google-chrome-stable -y
				;;
			
			9)
				echo "Installing Skype For Linux"
				apt install apt-transport-https -y
				curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
				echo "deb https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list
				apt update 
				apt install skypeforlinux -y
				;;
				
			10)
				echo "Installing Filezilla"
				sudo apt install filezilla -y
				;;

			11)
			echo "Installing Insomnia"
			echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
			# Add public key used to verify code signature
			wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
			# Refresh repository sources and install Insomnia	
			sudo apt update -y
			sudo apt install insomnia -y
			;;

			12)
			echo "Installing gdebi"
			sudo apt install gdebi -y
			;;

			13)
			echo "Installing transmission"
			sudo apt install transmission -y
			;;

			14)
			echo "Installing cutecom"
			sudo apt install cutecom -y
			;;

			15)
			echo "Installing slack"
			sudo snap install slack --classic
			;;

			16)
			echo "Installing gimp"
			sudo apt install gimp -y
			;;
				
			17) 
			echo "Installing Kicad"
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
			echo -e "${RED}Installing Wine${RESTORE}"
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
			echo -e "${GREEN}Installing Dash to Dock${RESTORE}"
			echo -e "${RED}still need to work out the way to get this handy tweak${RESTORE}"
			;;

			21) 
			echo -e "${GREEN}Installing Steam${RESTORE}"
			sudo apt install steam-installer -y
			steam
			;;

			22)
			echo -e "${GREEN}Installing hamatchi${RESTORE}" 
			sudo add-apt-repository -y ppa:webupd8team/haguichi
			sudo apt update
			sudo apt install -y haguichi
			;;

			23) 
			echo "Eagle"
			#https://github.com/Blunk-electronic/EAGLE_Linux_Installer
			;;
					
	    esac
	done
fi

