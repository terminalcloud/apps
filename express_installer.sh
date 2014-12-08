#!/bin/bash
# Script to deploy NodeJS DevStack at Terminal.com

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
	# Install nodejs, npm an mongodb
	apt-get -y install nodejs npm mongodb
	# Install bower, express and express generator
	npm install -g bower
	npm install -g express
	npm install -g express-generator@4
	# Install angular.js
	bower install --allow-root angular#1.2.26 
	# Get express examples
	git clone https://github.com/strongloop/express.git
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/express_hooks.sh
	mkdir -p /CL/hooks/
	mv express_hooks.sh /CL/hooks/startup.sh
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
