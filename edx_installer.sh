#!/bin/bash
# Script to deploy edX at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	sudo apt-get install -y build-essential software-properties-common python-software-properties curl git-core libxml2-dev libxslt1-dev libfreetype6-dev python-pip python-apt python-dev
	sudo pip install --upgrade pip
	sudo pip install --upgrade virtualenv
	mkdir -p /var/tmp
	cd /var/tmp
	git clone -b release https://github.com/edx/configuration
	cd /var/tmp/configuration
	pip install -r requirements.txt
	cd /var/tmp/configuration/playbooks && ansible-playbook -c local ./edx_sandbox.yml -i "localhost,"
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/edx_hooks.sh
	mkdir -p /CL/hooks/
	mv edx_hooks.sh /CL/hooks/startup.sh
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