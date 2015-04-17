#!/bin/bash
# Script to deploy ERPNext at Terminal.com
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

	# Procedure: 
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
	sudo add-apt-repository "deb http://ams2.mirrors.digitalocean.com/mariadb/repo/5.5/ubuntu $OS_VER main"

	apt-get -y install python-dev python-setuptools build-essential python-mysqldb git memcached \
	ntp vim screen htop mariadb-server mariadb-common libmariadbclient-dev  libxslt1.1 libxslt1-dev \
	redis-server libssl-dev libcrypto++-dev postfix nginx supervisor python-pip fontconfig libxrender1
	echo "It's recommended to stop here and proceed using a **bench** user"
	git clone https://github.com/frappe/bench bench-repo
	sudo pip install -e bench-repo/
	bench patch mariadb-config
	/etc/init.d/redis-server restart
	bench init frappe-bench && cd frappe-bench
	bench get-app erpnext https://github.com/frappe/erpnext
	bench new-site erpsite3 
	bench frappe --install_app erpnext erpsite3
	bench start
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/erpnext_hooks.sh
	mkdir -p /CL/hooks/
	mv erpnext_hooks.sh /CL/hooks/startup.sh
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