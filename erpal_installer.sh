#!/bin/bash
# Script to deploy Erpal at Terminal.com

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
	mysql_setup erpal erpal terminal
	cd $INSTALL_PATH
	wget http://ftp.drupal.org/files/projects/erpal-7.x-2.0-core.zip
	unzip erpal-7.x-2.0-core.zip && rm erpal-7.x-2.0-core.zip
	mv erpal-7.x-2.0-core erpal
	chown -R www-data:www-data erpal
	apache_install
	apache_default_vhost erpal.conf $INSTALL_PATH/erpal
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/erpal_hooks.sh
	mkdir -p /CL/hooks/
	mv erpal_hooks.sh /CL/hooks/startup.sh
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