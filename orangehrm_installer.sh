#!/bin/bash
# Script to deploy OrangeHRM at Terminal.com

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
	mysql_setup ohrm ohrm terminal
	cd $INSTALL_PATH
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/orangehrm-3.1.2.zip
	unzip orangehrm-3.1.2.zip && rm orangehrm-3.1.2.zip
	mv orangehrm-3.1.2 ohrm
	chown -R www-data:www-data ohrm
	apache_install
	apache_default_vhost ohrm.conf $INSTALL_PATH/ohrm
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 64M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 128M/g' /etc/php5/apache2/php.ini
	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 156M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/orangehrm_hooks.sh
	mkdir -p /CL/hooks/
	mv orangehrm_hooks.sh /CL/hooks/startup.sh
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