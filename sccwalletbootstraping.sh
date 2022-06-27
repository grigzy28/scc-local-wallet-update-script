#!/bin/bash

coinname=stakecubecoin
coindir=stakecubecoin
coindir2=scc
snapshot='https://stakecubecoin.net/bootstrap.zip'

#pre-setup checks and dependencies installs
echo -e "Checking/installing other script dependency's"
apt -y -qq install curl zip unzip nano ufw software-properties-common pwgen

#color variables
readonly GRAY='\e[1;30m'
readonly DARKRED='\e[0;31m'
readonly RED='\e[1;31m'
readonly DARKGREEN='\e[0;32m'
readonly GREEN='\e[1;32m'
readonly DARKYELLOW='\e[0;33m'
readonly YELLOW='\e[1;33m'
readonly DARKBLUE='\e[0;34m'
readonly BLUE='\e[1;34m'
readonly DARKMAGENTA='\e[0;35m'
readonly MAGENTA='\e[1;35m'
readonly DARKCYAN='\e[0;36m'
readonly CYAN='\e[1;36m'
readonly UNDERLINE='\e[1;4m'
readonly NC='\e[0m'

echo -e "${YELLOW}Do you wish to run the stakecube linux LOCAL WALLET extraction tool${NC}"
read linuxextraction

echo -e ""

echo -e "${YELLOW}Do you wish to update the offline chain file first?"
echo -e "${CYAN}Please enter ${MAGENTA}yes${NC} ${CYAN}or${NC} ${MAGENTA}no${CYAN} only${NC}"
read updatechainfile

if [[ $updatechainfile == "yes" ]]
	then
		echo -e "${CYAN}Downloading updated bootstrap for offline install/repair${NC}"
		cd ~
		wget -nv --show-progress ${snapshot} -O ${coinname}.zip
		echo -e ""
fi

if [[ $linuxextraction == "yes" ]]
	then
		find ~/.${coindir}/ -name ".lock" -delete
		find ~/.${coindir}/ -name ".walletlock" -delete
		find ~/.${coindir}/* ! -name "wallet.dat" ! -name "*.conf" -delete
		echo -e "${YELLOW}Downloading/Copying and replacing chain files for ${MAGENTA}$alias${NC}"

		sccfile=~/${coinname}.zip

		if test -e "$sccfile"
			then
				#rsync -adm --info=progress2 /root/${coinname}.zip /home/$alias
				unzip ~/${coinname}.zip
				rsync -r --info=progress2 ~/.${coindir2}/* ~/.${coinname}
				rm -f -r .${coindir2}
				echo -e "${YELLOW}$coinname local bootstrap directory updated${NC}"
				#echo -e "${YELLOW}Removing copied temp file${NC}"
				#rm /home/${alias}/${coinname}.zip
			else
				echo -e "${RED}File doesn't exist${NC}, ${YELLOW}downloading chain${NC}"
				wget -nv --show-progress ${snapshot} -O ${coinname}.zip
				unzip ${coinname}.zip
				rsync -r --info=progress2 ~/.${coindir2}/* ~/.${coinname}
				rm -f -r .${coindir2}
				echo -e "${YELLOW}$coinname chain directory updated${NC}"
				echo -e "${YELLOW}Removing downloaded temp file${NC}"
				rm ~/${coinname}.zip
		fi

	else
		echo -e "${YELLOW}Not running tool${NC}"
		exit
fi

