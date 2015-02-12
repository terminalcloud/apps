#!/bin/bash
# Script to deploy Owncloud at Terminal.com

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
	mysql_setup owncloud owncloud terminal
	cd $INSTALL_PATH
	wget https://download.owncloud.org/community/owncloud-8.0.0.tar.bz2
    tar -xjvf owncloud-8.0.0.tar.bz2
  	chown -R www-data:www-data owncloud
  	apache_install
  	apache_default_vhost owncloud.conf $INSTALL_PATH/owncloud
  	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 1024M/g' /etc/php5/apache2/php.ini
  	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 128M/g' /etc/php5/apache2/php.ini
  	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini
  	echo 'default_charset = "UTF-8"' >> /etc/php5/apache2/php.ini
  	service apache2 restart || service httpd restart
  	}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/owncloud_hooks.sh
	mkdir -p /CL/hooks/
	mv owncloud_hooks.sh /CL/hooks/startup.sh
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
