#!/bin/bash
# Script to deploy Ushahidi at Terminal.com

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
	mysql_setup ushahidi terminal
	apt-get -y install php5-imap 
	cd $INSTALL_PATH
	git clone https://github.com/ushahidi/platform.git ushahidi
	composer_install
	apache_install
	apache_default_vhost ushahidi.conf $INSTALL_PATH/ushahidi
	chown -R www-data:www-data $INSTALL_PATH/ushahidi
	curl http://npmjs.org/install.sh | sh
	npm install bower
	cd ushahidi
	bin/update
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 20M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 24M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/prestashop_hooks.sh
	mkdir -p /CL/hooks/
	mv prestashop_hooks.sh /CL/hooks/startup.sh
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