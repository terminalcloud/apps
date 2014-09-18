#!/bin/bash
# Script to deploy Wallabag at Terminal.com

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
	composer_install
	mysql_install
	mysql_setup wallabag wallabag terminal
	apt-get -y install libtidy libtidy-dev || yum -y install libtidy libtidy-dev 
	cd $INSTALL_PATH
	wget -q http://wllbg.org/latest
	unzip latest
	mv wallabag* wallabag
	chown -R www-data:www-data wallabag
	cd wallabag
	composer install
	apache_install
	apache_default_vhost wallabag $INSTALL_PATH/wallabag
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/wallabag_hooks.sh
	mkdir -p /CL/hooks/
	mv wallabag_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install #&& show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi