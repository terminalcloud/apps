#!/bin/bash
# Script to deploy a Nginx Load Balancer at Terminal.com
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


INSTALL_PATH="/opt/loadbalancer" # If you change this location,
# you will have to change the nginx-lb.conf file as well.

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  pkg_update
  system_cleanup
  basics_install

  # Procedure:
  mkdir -p $INSTALL_PATH/etc
  mkdir -p $INSTALL_PATH/bin
  mkdir -p $INSTALL_PATH/log
  cd $INSTALL_PATH/etc
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/nginx-lb.conf
  cd $INSTALL_PATH/bin
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/node-registrar.js
  wget -q -N  https://raw.githubusercontent.com/terminalcloud/apps/master/others/nginx-lb_cfg.sh
  chmod +x *
  apt-get -y install nodejs npm build-essential libssl-dev nginx
  npm install exec-sync restify
  npm install -g forever
  ln -s $INSTALL_PATH/etc/nginx-lb.conf /etc/nginx/sites-enabled/nginx-lb.conf
  rm /etc/nginx/sites-enabled/default
  ln -s /var/run/nginx.pid $INSTALL_PATH/etc/nginx.pid
  #apt-get -y install nfs-server
  #mkdir -p /shared
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/nginx-lb_hooks.sh
  mkdir -p /CL/hooks/
  mv nginx-lb_hooks.sh /CL/hooks/startup.sh
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
