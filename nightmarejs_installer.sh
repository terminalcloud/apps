#!/bin/bash
# Script to deploy NightmareJS and it's dependencies at Terminal.com

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
	apt-get -y install build-essential nodejs phantomjs 
	mkdir $INSTALL_PATH/nightmarejs
	cd $INSTALL_PATH/nightmarejs
	npm install node
	npm install casper
	npm install phantomjs
	npm install nightmare
	# Get the example
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/nightmarejs_example.js.sh
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/nightmarejs_hooks.sh
	mkdir -p /CL/hooks/
	mv nightmarejs_hooks.sh /CL/hooks/startup.sh
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