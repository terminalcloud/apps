#!/bin/bash
# Script to deploy Subrion at Terminal.com

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
  php5_install
  mysql_install
  mysql_setup subrion subrion terminal
  mkdir -p $INSTALL_PATH/subrion
  cd $INSTALL_PATH/subrion
  wget -O subrion.zip http://tools.subrion.org/get/latest.zip
  unzip subrion.zip && rm subrion.zip
  cd $INSTALL_PATH
  chown -R www-data:www-data subrion
  apache_install
  apache_default_vhost subrion.conf $INSTALL_PATH/subrion
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 64M/g' /etc/php5/apache2/php.ini
  sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 184M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/subrion_hooks.sh
  mkdir -p /CL/hooks/
  mv subrion_hooks.sh /CL/hooks/startup.sh
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
