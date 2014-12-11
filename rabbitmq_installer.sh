#!/bin/bash
# Script to install RabbitMQ at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install
  pulldocker_install

  # Procedure:
  cd $INSTALL_PATH

  # Get the app docker dump
  pulldocker tutum/rabbitmq
  chmod +x tutum/rabbitmq/run.sh

  # Fix some permissions
  chroot tutum/rabbitmq chown -R rabbitmq:rabbitmq /var/log/rabbitmq/

  # Create startup script to launch the jail:
  echo 'echo "Starting app jail" ; chroot tutum/rabbitmq/ sh run.sh&' > start.sh
  chmod +x start.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/rabbitmq_hooks.sh
  mkdir -p /CL/hooks/
  mv rabbitmq_hooks.sh /CL/hooks/startup.sh
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
