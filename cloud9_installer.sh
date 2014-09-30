#!/bin/bash
# Script to deploy Pimcore at Terminal.com

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
	apt-get install -y python-software-properties python make build-essential g++ curl libssl-dev apache2-utils git libxml2-dev
	apt-get -y remove nodejs
	cd $INSTALL_PATH
	git clone git://github.com/creationix/nvm.git ~/nvm
	echo '. ~/nvm/install.sh' && source ~/.bashrc
	nvm install v0.8.28
	nvm use v0.8.28
	npm install npm -g --ca=""
	npm install forever -g
	git clone https://github.com/ajaxorg/cloud9.git cloud9
	cd cloud9
	npm install packager
	npm install

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/cloud9_hooks.sh
	mkdir -p /CL/hooks/
	mv cloud9_hooks.sh /CL/hooks/startup.sh
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