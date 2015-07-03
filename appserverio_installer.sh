#!/bin/bash
# Script to deploy appserverio PM at Terminal.com
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
	echo "deb http://deb.appserver.io/ wheezy main" > /etc/apt/sources.list.d/appserver.list
    wget http://deb.appserver.io/appserver.gpg -O - | apt-key add -
    apt-get -y update
    apt-get -y install appserver-dist


    # Setting a phpinfo page running over appserver.io
    /opt/appserver/server.php -s dev
    mkdir -p /opt/appserver/webapps/test
    echo '<?php phpinfo(); ?>' > /opt/appserver/webapps/test/info.php
    sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /opt/appserver/etc/appserver/appserver.xml
    /etc/init.d/appserver restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/appserverio_hooks.sh
	mkdir -p /CL/hooks/
	mv appserverio_hooks.sh /CL/hooks/startup.sh
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