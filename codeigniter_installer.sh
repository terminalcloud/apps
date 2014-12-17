#!/bin/bash
# Script to deploy codeigniter3 at Terminal.com

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
  mysql_setup codeigniter codeigniter terminal
  cd $INSTALL_PATH
  wget -O codeigniter.zip https://codeload.github.com/bcit-ci/CodeIgniter/zip/develop
  unzip codeigniter.zip && rm codeigniter.zip
  mv CodeIgniter-develop codeigniter
  chown -R www-data:www-data codeigniter
  apache_install
  apache_default_vhost codeigniter.conf $INSTALL_PATH/codeigniter/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/codeigniter_hooks.sh
  mkdir -p /CL/hooks/
  mv codeigniter_hooks.sh /CL/hooks/startup.sh
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
