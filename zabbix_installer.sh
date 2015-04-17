#!/bin/bash
# Script to deploy Zabbix at Terminal.com
# Cloudlabs, INC. Copyright (C) 2015
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Cloudlabs, INC. - 653 Harrison St, San Francisco, CA 94107.
# http://www.terminal.com - help@terminal.com

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
	echo 'deb-src http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main' >> /etc/apt/sources.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C407E17D5F76A32B
	apt-get update
	apt-get install -y zabbix-server-mysql php5-mysql zabbix-frontend-php
	echo DBPassword=zabbix >> /etc/zabbix/zabbix_server.conf
    cd /usr/share/zabbix-server-mysql
    gunzip *
    mysql -uzabbix -pzabbix zabbix < schema.sql
    mysql -uzabbix -pzabbix zabbix < images.sql
    mysql -uzabbix -pzabbix zabbix < data.sql
    sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/apache2/php.ini
    sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php5/apache2/php.ini
    sed -i 's/max_input_time = 60/max_input_time = 300/g' /etc/php5/apache2/php.ini
    echo 'date.timezone = America/Los_Angeles' >>  /etc/php5/apache2/php.ini
    chmod -R o+r /etc/zabbix/
cat > /etc/zabbix/zabbix.conf.php << EOF
<?php
// Zabbix GUI configuration file
global $DB;

$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = 'localhost';
$DB['PORT']     = '0';
$DB['DATABASE'] = 'zabbix';
$DB['USER']     = 'zabbix';
$DB['PASSWORD'] = 'zabbix';

// SCHEMA is relevant only for IBM_DB2 database
$DB['SCHEMA'] = '';

$ZBX_SERVER      = '0.0.0.0';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = '';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
EOF

    cp /usr/share/doc/zabbix-frontend-php/examples/apache.conf /etc/apache2/conf-available/zabbix.conf
    a2enconf zabbix.conf
    a2enmod alias
    service apache2 restart
    sed -i 's/START\=no/START\=yes/g' /etc/default/zabbix-server
    service zabbix-server start

    # Install local agent
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