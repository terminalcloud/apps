#!/bin/bash
# Script to deploy Zurmo at Terminal.com

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
	mysql_setup zurmo zurmo terminal
	mysql -uroot -proot -e"set global max_allowed_packet=33554432"
	cd $INSTALL_PATH
	wget http://build.zurmo.com/downloads/zurmo-stable-2.8.3.5ca32e260e0e.zip
	unzip zurmo-stable-2.8.3.5ca32e260e0e.zip && rm zurmo-stable-2.8.3.5ca32e260e0e.zip
	chown -R www-data:www-data zurmo
	apache_install
	apache_default_vhost zurmo.conf $INSTALL_PATH/zurmo
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	apt-get -y install php5-memcache php5-ldap php5-imap php-apc memcached
	php5enmod imap
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/zurmo_hooks.sh
	mkdir -p /CL/hooks/
	mv zurmo_hooks.sh /CL/hooks/startup.sh
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