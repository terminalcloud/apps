#!/bin/bash
# Script to deploy Pootle at Terminal.com

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
  cd $INSTALL_PATH
  apt-get -y install python-pip || yum -y install python-pip
  pip install virtualenv
  virtualenv /var/www/pootle/env/
  source /var/www/pootle/env/bin/activate
  pip install Pootle
  pootle --version
  pootle init
  pootle setup
  pootle start
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/pootle_hooks.sh
  mkdir -p /CL/hooks/
  mv pootle_hooks.sh /CL/hooks/startup.sh
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
