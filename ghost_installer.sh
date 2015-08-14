#!/bin/bash
# Script to deploy ghost at Terminal.com
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
	cd $INSTALL_PATH
	curl -sL https://deb.nodesource.com/setup | sudo bash -
	apt-get -y update
	apt-get -y install nodejs build-essential libssl-dev supervisor
	npm install -g npm
	npm install -g ghost
	npm install -g forever
	ln -s /usr/local/lib/node_modules/ghost/ ghost
	mkdir -p /var/log/supervisor/
	sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /root/ghost/config.js
	sed -i 's/2368/80/g' /root/ghost/config.js
	sed -i 's/http\:\/\/my-ghost-blog\.com/https\:\/\/terminalservername\-80\.terminal\.com/g' /root/ghost/config.js
    cat > /etc/supervisor/conf.d/ghost.conf << EOF
[program:ghost]
command = node /root/ghost/index.js
directory = /root/ghost/
user = root
autostart = true
autorestart = true
stdout_logfile = /var/log/supervisor/ghost.log
stderr_logfile = /var/log/supervisor/ghost_err.log
environment = NODE_ENV="production"
EOF
    service supervisor restart
    supervisorctl restart ghost
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/ghost_hooks.sh
	mkdir -p /CL/hooks/
	mv nodebb_hooks.sh /CL/hooks/startup.sh
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