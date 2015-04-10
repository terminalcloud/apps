#!/bin/bash
# Script to deploy Zabbix at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install
	apache_install
	mysql_install
	php5_install

	# Procedure:
	wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+trusty_all.deb
    dpkg -i zabbix-release_2.2-1+trusty_all.deb
    apt-get -y install zabbix-server-mysql zabbix-frontend-php
    cp /etc/zabbix/apache.conf /etc/apache2/sites-enabled/zabbix.conf
    sed -i  's/\#php_value\ date\.timezone\ Europe\/Ria/php_value\ date\.timezone\ America\/Los_Angeles/g' /etc/apache2/sites-enabled/zabbix.conf
    service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/zabbix_hooks.sh
	mkdir -p /CL/hooks/
	mv zabbix_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
elif [[ $1 == "install"]]; then
    install
else
	echo "unknown parameter specified"
fi