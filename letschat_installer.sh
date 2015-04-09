#!/bin/bash
# Script to deploy Let's Chat at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	add-apt-repository -y ppa:chris-lea/node.js
	apt-get -y update
	apt-get -y install nodejs build-essential python mongodb
    git clone https://github.com/sdelements/lets-chat.git
    cd lets-chat
    npm install
	# LCB_HTTP_HOST=0.0.0.0 npm start
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/letschat_hooks.sh
	mkdir -p /CL/hooks/
	mv letschat_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi