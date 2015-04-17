#!/bin/bash
# Script to deploy SilverStripe at Terminal.com
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