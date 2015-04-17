#!/bin/bash
# Script to deploy Cloud9 at Terminal.com
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
	apt-get install -y python-software-properties python make build-essential g++ curl libssl-dev apache2-utils git libxml2-dev
	apt-get -y remove nodejs
	cd $INSTALL_PATH
	git clone git://github.com/creationix/nvm.git /root/nvm
	/root/nvm/install.sh
	source /root/.bashrc
	nvm install v0.8.28
	nvm use v0.8.28
	npm install forever -g
	git clone https://github.com/ajaxorg/cloud9.git cloud9
	cd cloud9
	npm install packager
	npm install
	forever start /root/cloud9/server.js -w /root -l 0.0.0.0 --username user --password terminal&


}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/cloud9_hooks.sh
	mkdir -p /CL/hooks/
	mv cloud9_hooks.sh /CL/hooks/startup.sh
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