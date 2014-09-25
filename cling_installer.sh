#!/bin/bash
# Script to deploy CLING at Terminal.com

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	[[ -f /etc/debian_version ]] && apt-get -y install gcc g++ || yum -y install gcc g++
	wget https://ecsft.cern.ch/dist/cling/current/cling-Ubuntu-14.04-64bit-b714047cbb.tar.bz2
	tar jfxv cling-Ubuntu-14.04-64bit-b714047cbb.tar.bz2
	mv cling-Ubuntu-14.04-64bit-b714047cbb cling
	echo "PATH=$PATH:/root/cling/bin" >> .profile
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/cling_hooks.sh
	mkdir -p /CL/hooks/
	mv cling_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	clear
	echo "PRESS ENTER TO START CLING"
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
	source .profile
	clear
	cling
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi