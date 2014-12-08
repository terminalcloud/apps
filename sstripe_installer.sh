#!/bin/bash
# Script to deploy SilverStripe at Terminal.com

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
	mysql_install terminal
	mysql_setup sstripe sstripe terminal
	cd $INSTALL_PATH
	composer create-project silverstripe/installer silverstripe 3.1.6
	chown -R www-data:www-data silverstripe
	apache_install
	apt-get -y install libtidy-dev php5-tidy || yum -y install libtidy libtidy-dev php-tidy
	apache_default_vhost sstripe.conf $INSTALL_PATH/silverstripe 
	sed -i 's/\;date\.timezone\ \=/date\.timezone\ \= America\/Los_Angeles/g' /etc/php5/apache2/php.ini
	sed -i 's/Directory\ \//Directory\ \/var\/www\/silverstripe/g' /etc/apache2/sites-available/silverstripe.conf
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/sstripe_hooks.sh
	mkdir -p /CL/hooks/
	mv sstripe_hooks.sh /CL/hooks/startup.sh
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