#!/bin/bash
# Script to deploy Pydio at Terminal.com

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
	echo 'deb http://dl.ajaxplorer.info/repos/apt stable main' >> /etc/apt/sources.list	
	echo 'deb-src http://dl.ajaxplorer.info/repos/apt stable main' >> /etc/apt/sources.list
	wget -O - http://dl.ajaxplorer.info/repos/charles@ajaxplorer.info.gpg.key | sudo apt-key add -
	apt-get -y update
	apt-get -y install pydio
	cp /usr/share/doc/pydio/apache2.sample.conf /etc/apache2/sites-enabled/pydio.conf
	php5_install
	mysql_install
	mysql_setup pydio pydio terminal
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/pydio_hooks.sh
	mkdir -p /CL/hooks/
	mv pydio_hooks.sh /CL/hooks/startup.sh
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