#!/bin/bash
# Script to deploy Phoenix at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install

  # Procedure:
  cd $INSTALL_PATH
  wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
  dpkg -i erlang-solutions_1.0_all.deb
  apt-get update
  apt-get install elixir
  git clone https://github.com/phoenixframework/phoenix.git
  cd phoenix
  git checkout v0.6.0
  mix do deps.get, compile

  # Create a sample Phoenix Application
  cd $INSTALL_PATH
  mix phoenix.new my_app ./my_phoenix_app
  cd ./my_phoenix_app
  mix do deps.get, compile
  mix phoenix.start
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/phoenix_hooks.sh
  mkdir -p /CL/hooks/
  mv phoenix_hooks.sh /CL/hooks/startup.sh
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
