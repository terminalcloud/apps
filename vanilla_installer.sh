#!/bin/bash
# Script to deploy Vanilla at Terminal.com

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
	mysql_setup vanilla vanilla terminal
	cd $INSTALL_PATH
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/other/vanilla-core-2-1-3.zip
	unzip vanilla-core-2-1-3.zip
	chown -R www-data:www-data vanilla
	apache_install
	apache_default_vhost vanilla.conf $INSTALL_PATH/vanilla
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini	
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/vanilla_hooks.sh
	mkdir -p /CL/hooks/
	mv vanilla_hooks.sh /CL/hooks/startup.sh
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