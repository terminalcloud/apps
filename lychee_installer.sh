#!/bin/bash
# Script to deploy Lychee at Terminal.com

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
	mysql_setup lychee lychee terminal
	cd $INSTALL_PATH
	git clone https://github.com/electerious/Lychee.git
	mv Lychee lychee
	chown -R www-data:www-data lychee
	apache_install
	apt-get -y install php5-imagick || yum -y install php5-imagick
	apache_default_vhost wallabag.conf $INSTALL_PATH/lychee
	cat > lychee/data/config.php << EOF
<?php
if(!defined('LYCHEE')) exit('Error: Direct access is not allowed!');
$dbHost = 'localhost'; # Host of the database
$dbUser = 'lychee'; # Username of the database
$dbPassword = 'terminal'; # Password of the database
$dbName = 'lychee'; # Database name
$dbTablePrefix = ''; # Table prefix
?>
EOF
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/lychee_hooks.sh
	mkdir -p /CL/hooks/
	mv lychee_hooks.sh /CL/hooks/startup.sh
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