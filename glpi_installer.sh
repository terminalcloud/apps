#!/bin/bash
# Script to deploy GLPI at Terminal.com

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
	mysql_setup glpi glpi terminal
	cd $INSTALL_PATH
	wget https://forge.indepnet.net/attachments/download/1811/glpi-0.84.7.tar.gz
	gunzip glpi-0.84.7.tar.gz && tar -xf glpi-0.84.7.tar && rm glpi-0.84.7.tar
	mv glpi-0.84.7 glpi
	chown -R www-data:www-data glpi
	apache_install
	apache_default_vhost glpi.conf $INSTALL_PATH/glpi
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 64M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 128M/g' /etc/php5/apache2/php.ini
	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/glpi_hooks.sh
	mkdir -p /CL/hooks/
	mv glpi_hooks.sh /CL/hooks/startup.sh
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