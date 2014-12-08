#!/bin/bash
# Script to deploy Seafile at Terminal.com

INSTALL_PATH="/opt/seafile"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  pkg_update
  system_cleanup
  basics_install

  # Procedure:
  mkdir -p $INSTALL_PATH
  cd $INSTALL_PATH
  apt-get -y install python-pip python-imaging sqlite3
  wget https://bitbucket.org/haiwen/seafile/downloads/seafile-server_3.1.7_x86-64.tar.gz
  tar -xzf seafile-server_3.1.7_x86-64.tar.gz && rm seafile-server_3.1.7_x86-64.tar.gz
  mv seafile-server-3.1.7/ seafile-server
  cd seafile-server
  ./setup-seafile.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/seafile_hooks.sh
  mkdir -p /CL/hooks/
  mv seafile_hooks.sh /CL/hooks/startup.sh
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
