#!/bin/bash
# Script to deploy the Fb's Proxygen Library at Terminal.com

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
  git clone https://github.com/facebook/proxygen.git
  apt-get -y install build-essential
  cd proxygen/proxigen
  ./deps.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/proxygen_hooks.sh
  mkdir -p /CL/hooks/
  mv proxygen_hooks.sh /CL/hooks/startup.sh
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
