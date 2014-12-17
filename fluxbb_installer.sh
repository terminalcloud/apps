#!/bin/bash
# Script to deploy fluxbb3 at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install

  # Procedure:
  php5_install
  mysql_install
  mysql_setup fluxbb fluxbb terminal
  cd $INSTALL_PATH
  wget -O fluxbb.zip file:///home/concien1/Downloads/fluxbb-1.5.7.zip
  unzip fluxbb.zip && rm fluxbb.zip
  mv fluxbb-1.5.7 fluxbb
  chown -R www-data:www-data fluxbb
  apache_install
  apache_default_vhost fluxbb.conf $INSTALL_PATH/fluxbb/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/fluxbb_hooks.sh
  mkdir -p /CL/hooks/
  mv fluxbb_hooks.sh /CL/hooks/startup.sh
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
