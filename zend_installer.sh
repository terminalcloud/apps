#!/bin/bash
# Script to deploy Zend Framework and a sample app at Terminal.com
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


# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	# 1 - Get prerrequisites.
	apache_install
	mysql_install
	mysql_setup stickynotes zend terminal
	php5_install
	composer_install

	# 2 - Install the product
	cd $INSTALL_PATH
	apache_default_vhost sample.conf $INSTALL_PATH/Zend-Sticky/public 
	wget -q https://github.com/terminalcloud/apps/raw/master/others/Zend-Sticky-master.zip
	unzip Zend-Sticky-master.zip
	mv Zend-Sticky-master Zend-Sticky
	composer self-update
	cd $INSTALL_PATH/Zend-Sticky 
	composer install
	chown -R www-data:www-data $INSTALL_PATH/Zend-Sticky 
	mysql -uzend -pterminal stickynotes < schema.sql
	mysql -uzend -pterminal stickynotes < inserts.sql
	service apache2 restart
}


show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/zend.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh zend.md
	cd.sh /var/www/ ## Show the served directory
	browse.sh localhost:80
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi