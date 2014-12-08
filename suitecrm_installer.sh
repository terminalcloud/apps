#!/bin/bash
# Script to deploy SuiteCRM at Terminal.com

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
	## mysql_setup suitecrm suitecrm terminal - Let the installed create the DB.
	cd $INSTALL_PATH
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/SuiteCRM-7.1.4_MAX.zip
	unzip SuiteCRM-7.1.4_MAX.zip && rm SuiteCRM-7.1.4_MAX.zip
	mv suitecrm-7.1.4-max suitecrm
	chown -R www-data:www-data suitecrm
	apache_install
	apache_default_vhost suitecrm.conf $INSTALL_PATH/suitecrm
	apt-get -y install php5-imap || yum -y install php-imap
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	echo "*    *    *    *    *     cd /var/www/suitecrm; php -f cron.php > /dev/null 2>&1" >> /var/spool/cron/crontabs/root
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/suitecrm_hooks.sh
	mkdir -p /CL/hooks/
	mv suitecrm_hooks.sh /CL/hooks/startup.sh
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