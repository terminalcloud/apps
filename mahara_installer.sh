#!/bin/bash
# Script to deploy Mahara at Terminal.com

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
	mysql_setup mahara mahara terminal
	cd $INSTALL_PATH
	wget https://launchpad.net/mahara/1.9/1.9.2/+download/mahara-1.9.2.zip
	unzip mahara-1.9.2.zip && rm mahara-1.9.2.zip
	mv mahara-1.9.2/htdocs mahara && rm -r mahara-1.9.2
	chown -R www-data:www-data mahara
	cd mahara
	mysql -uroot -proot -e"ALTER DATABASE mahara CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/mahara_config.php && cp mahara_config.php config.php  
	echo "* * * * * curl http://your-mahara-site.org/lib/cron.php" > /var/spool/cron/crontabs/root
	apache_install
	apache_default_vhost mahara.conf $INSTALL_PATH/mahara
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/mahara_hooks.sh
	mkdir -p /CL/hooks/
	mv mahara_hooks.sh /CL/hooks/startup.sh
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