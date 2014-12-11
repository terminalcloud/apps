#!/bin/bash
# Script to hi5ai at Terminal.com

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
  pulldocker clue/hi5ai

  # Link the data directory to the data folder outside the jail
  # (this is like exposing path with docker, using VOLUME)
  ln -s clue/hi5ai/var/www data

  # Create a startup script for the App jail
  cat > clue/hi5ai/start.sh << EOF
cd /var/www
supervisord -c /etc/supervisor/conf.d/supervisord.conf
EOF

  # Fix permissions
  chroot clue/hi5ai chown -R www-data:www-data /var/www
  # Create startup script to launch the jail:
  echo 'echo "Starting app jail" ; chroot clue/hi5ai sh start.sh&' > start.sh
  chmod +x start.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/hi5ai_hooks.sh
  mkdir -p /CL/hooks/
  mv hi5ai_hooks.sh /CL/hooks/startup.sh
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
