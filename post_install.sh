#!/bin/bash

#with respect to https://github.com/waleedahmad

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

			 30 "Generate SSH Keys" off
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
				sudo apt install python -y && sudo apt install python3 -y
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
			echo "Installing MySQLWorkbench"
			echo "still need to work out the way to install 4.2.6"
			;;


			30)
				echo "Generating SSH keys"
				ssh-keygen -t rsa -b 4096
				;;
			
	    esac
	done
fi
