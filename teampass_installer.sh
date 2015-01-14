#!/bin/bash
# Script to deploy TeamPass at Terminal.com

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
	mysql_setup teampass teampass terminal
	mysql -uroot -proot -e"set global max_allowed_packet=33554432"
	cd $INSTALL_PATH
	wget https://github.com/nilsteampassnet/TeamPass/archive/master.zip
	unzip Release_2.1.21.zip && rm Release_2.1.21.zip
	mv TeamPass-Release_2.1.21 teampass
	chown -R www-data:www-data teampass
	apache_install
  apt-get -y install php5-gmp
	apache_default_vhost teampass.conf $INSTALL_PATH/teampass
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini
  sed -i 's/max_execution_time\ \=\ 30/max_execution_time\ \=\ 90/g' /etc/php5/apache2/php.ini

	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/teampass_hooks.sh
	mkdir -p /CL/hooks/
	mv teampass_hooks.sh /CL/hooks/startup.sh
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
