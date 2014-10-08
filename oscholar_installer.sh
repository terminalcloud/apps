#!/bin/bash
# Script to deploy OpenScholar at Terminal.com

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
	mysql_setup oscholar oscholar terminal
	cd $INSTALL_PATH
	wget http://theopenscholar.org/sites/osops.openscholar.harvard.edu/files/theopenscholar/files/drupal-openscholar-7.x-3.16.0.tar.gz
	unzip drupal-openscholar-7.x-3.16.0 && rm drupal-openscholar-7.x-3.16.0
	mv drupal-openscholar-7.x-3.16.0 oscholar
	chown -R www-data:www-data oscholar
	apache_install
	apache_default_vhost oscholar.conf $INSTALL_PATH/oscholar
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 300M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/oscholar_hooks.sh
	mkdir -p /CL/hooks/
	mv oscholar_hooks.sh /CL/hooks/startup.sh
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