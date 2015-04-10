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
	mysql_setup zabbix zabbix zabbix
	php5_install

	# Procedure:
	echo 'deb http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main' >> /etc/apt/sources.list
	echo 'eb-src http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main' >> /etc/apt/sources.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C407E17D5F76A32B
	apt-get update
	apt-get install zabbix-server-mysql php5-mysql zabbix-frontend-php
	echo DBPassword=zabbix >> /etc/zabbix/zabbix_server.conf
	cd /usr/share/zabbix-server-mysql
	gunzip *
    mysql -u zabbix -p zabbix < schema.sql
    mysql -u zabbix -p zabbix < images.sql
    mysql -u zabbix -p zabbix < data.sql
    cp /usr/share/doc/zabbix-frontend-php/examples/apache.conf /etc/apache2/conf-available/zabbix.conf
    a2enconf zabbix.conf
    a2enmod alias
    service apache2 restart
    sed -i 's/START\=no/START\=yes/g' /etc/default/zabbix-server
    service zabbix-server start
    apt-get install zabbix-agent
    service zabbix-agent restart
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
elif [[ $1 == "install" ]]; then
    install
else
	echo "unknown parameter specified"
fi