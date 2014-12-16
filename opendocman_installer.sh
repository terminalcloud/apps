#!/bin/bash
# Script to deploy opendocman at Terminal.com

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
  mysql_setup opendocman opendocman terminal
  cd $INSTALL_PATH
  mkdir opendocman && cd opendocman
  wget -O opendocman.zip http://downloads.sourceforge.net/project/opendocman/opendocman/1.2.9/opendocman-1.2.9.zip
  unzip opendocman.zip && rm opendocman.zip
  mv opendocman-1.2.9 opendocman
  cd $INSTALL_PATH
  chown -R www-data:www-data opendocman
  apache_install
  apache_default_vhost opendocman.conf $INSTALL_PATH/opendocman/opendocman
  mkdir $INSTALL_PATH/odm_data/
  chown -R www-data:www-data odm_data
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 30M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/opendocman_hooks.sh
  mkdir -p /CL/hooks/
  mv opendocman_hooks.sh /CL/hooks/startup.sh
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
