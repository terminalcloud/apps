#!/bin/bash
# Script to deploy Squash at Terminal.com

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
  git clone https://github.com/SquareSquash/web.git
  apt-get -y install ruby postgresql ruby1.9.1-dev libpq-dev g++
  cd web
  gem install bundler
  ./setup.rb
  # You need to make sure that the user running the installation have superuser permissions over postgreSQL.
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/squash_hooks.sh
  mkdir -p /CL/hooks/
  mv squash_hooks.sh /CL/hooks/startup.sh
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
