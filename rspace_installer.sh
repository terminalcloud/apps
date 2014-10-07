#!/bin/bash
# Script to deploy Resource Space at Terminal.com

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
	php5_install
	mysql_install
	mysql_setup rspace rspace terminal
	cd $INSTALL_PATH
	mkdir -p $INSTALL_PATH/rspace
	cd $INSTALL_PATH/rspace
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/ResourceSpace.zip
	unzip ResourceSpace.zip && rm ResourceSpace.zip
	cd $INSTALL_PATH
	chown -R www-data:www-data rspace
	apache_install
	apache_default_vhost rspace.conf $INSTALL_PATH/rspace
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/rspace_hooks.sh
	mkdir -p /CL/hooks/
	mv rspace_hooks.sh /CL/hooks/startup.sh
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