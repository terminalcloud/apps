#!/bin/bash
# Script to deploy Structr at Terminal.com

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	apt-get -y install openjdk-7-jdk
	apt-get -f install
	wget https://oss.sonatype.org/content/repositories/releases/org/structr/structr-ui/1.0.0/structr-ui-1.0.0.deb
	dpkg -i structr-ui-1.0.0.deb || (apt-get -f install && dpkg -i structr-ui-1.0.0.deb)
	service structr-ui start
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/structr_hooks.sh
	mkdir -p /CL/hooks/
	mv structr_hooks.sh /CL/hooks/startup.sh
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