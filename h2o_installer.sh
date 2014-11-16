#!/bin/bash
# Script to deploy H2O at Terminal.com

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
  java8_oracle_install
  wget https://s3.amazonaws.com/h2o-release/h2o/rel-markov/1/h2o-2.8.1.1.zip
  unzip h2o-2.8.1.1.zip && rm h2o-2.8.1.1.zip
  mv h2o-2.8.1.1 h2o
}


show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/h2o_hooks.sh
  mkdir -p /CL/hooks/
  mv h2o_hooks.sh /CL/hooks/startup.sh
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
