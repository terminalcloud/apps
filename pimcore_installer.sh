#!/bin/bash
# Script to deploy Pimcore at Terminal.com

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
	mysql_setup pimcore pimcore terminal
	cd $INSTALL_PATH
	mkdir -p $INSTALL_PATH/pimcore
	wget https://www.pimcore.org/download/pimcore-data.zip
	unzip pimcore-data.zip -d pimcore
	rm pimcore-data.zip
	chown -R www-data:www-data pimcore
	apache_install
	apache_default_vhost pimcore.conf $INSTALL_PATH/pimcore
	sed -i 's/Directory\ \//Directory\ \/var\/www\/pimcore/g' /etc/apache2/sites-available/pimcore.conf
	service apache2 restart
	echo "*/5 * * * * /usr/bin/php /var/www/pimcore/cli/maintenance.php" >> /var/spool/cron/crontabs/root
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/pimcore_hooks.sh
	mkdir -p /CL/hooks/
	mv pimcore_hooks.sh /CL/hooks/startup.sh
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