#!/bin/bash
# Script to deploy Ushahidi at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install_deployment(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	php5_install
	mysql_install
	mysql_setup ushahidi ushahidi terminal
	apt-get -y install php5-imap rails
	cd $INSTALL_PATH
	git clone https://github.com/ushahidi/platform.git ushahidi
	composer_install
	apache_install
	apache_default_vhost ushahidi.conf $INSTALL_PATH/ushahidi/httpdocs
	chown -R www-data:www-data $INSTALL_PATH/ushahidi
	curl http://npmjs.org/install.sh | sh
	cd $INSTALL_PATH 
	npm install -g bundle
	bower install --allow-root
	bin/update
	cd ..

	#cp $INSTALL_PATH/ushahidi/httpdocs/template.htaccess $INSTALL_PATH/ushahidi/httpdocs/.htaccess
	#application/config/database.php
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 20M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 24M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	php5_install
	mysql_install
	mysql_setup ushahidi ushahidi terminal
	apt-get -y install php5-imap
	apache_install
	apache_default_vhost ushahidi.conf $INSTALL_PATH/ushahidi/httpdocs
	wget http://download.ushahidi.com/track_download.php?download=ushahidi
	mv track_download* ushahidi.zip
	unzip ushahidi.zip
	chown -R www-data:www-data $INSTALL_PATH/ushahidi
}


show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/ushahidi_hooks.sh
	mkdir -p /CL/hooks/
	mv ushahidi_hooks.sh /CL/hooks/startup.sh
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