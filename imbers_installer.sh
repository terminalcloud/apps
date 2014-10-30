#!/bin/bash
# Script to deploy Imbers at Terminal.com

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
	curl -L get.rvm.io | bash -s stable # Requires Basics
	source /usr/local/rvm/scripts/rvm
	echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
	rvm install 2.1.1
	rvm use current 2.1.1
	rvm rubygems current
	apt -y install postgresql redis-server
	wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
	echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
	apt-get update
	apt-get install neo4j
	git clone https://github.com/52unicorns/imbers-backend.git
}


show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/imbers_hooks.sh
	mkdir -p /CL/hooks/
	mv imbers_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install #&& show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi