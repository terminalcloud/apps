#!/bin/bash
# Script to deploy Laverna Notes at Terminal.com
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
	apache_install
	cd "$INSTALL_PATH"
	git clone -b gh-pages https://github.com/Laverna/static-laverna
	mv static-laverna/ laverna
    apache_default_vhost laverna.conf $INSTALL_PATH/laverna/
}


show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/laverna.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh laverna.md
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