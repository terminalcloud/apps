#!/bin/bash
# Script to deploy a Nginx Load Balancer at Terminal.com

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
  apt-get -y install nodejs npm build-essential libssl-dev
  npm install exec-sync restify
  npm install -g forever
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
