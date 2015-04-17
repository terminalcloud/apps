#!/bin/bash
# Script to deploy PhusionPassenger at Terminal.com
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
NGINX_PATH="/opt/nginx"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Installation
	source /usr/local/rvm/scripts/rvm
	ruby_install rails

	# Compilation
	gem install passenger
	passenger-install-nginx-module --auto --auto-download --prefix="$NGINX_PATH" --languages ruby,python,nodejs,meteor
	
	# Rails example setup and stuff
	cd $INSTALL_PATH
	gem install serious
	serious blog --public --no-git
	chmod -R 777 blog/

	# Nginx conf and server block for passenger example and start Nginx
	wget -O - https://raw.githubusercontent.com/terminalcloud/apps/master/others/passenger_serious_nginx.conf > "$NGINX_PATH"/conf/nginx.conf
	"$NGINX_PATH"/sbin/nginx
}


show(){
	cd $HOME
	export PATH=$PATH:/srv/cloudlabs/scripts
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/docs/phusionpassenger.md
	edit.sh ~/phusionpassenger.md
	cd.sh /var/www/blog
	start_hooks_install
	/CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi