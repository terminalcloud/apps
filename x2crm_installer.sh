#!/bin/bash
# Script to deploy x2crm at Terminal.com

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
  mysql_setup x2crm x2crm terminal
  cd $INSTALL_PATH
  wget -O x2crm.zip https://codeload.github.com/X2Engine/X2Engine/zip/4.2.1
  unzip x2crm.zip && rm x2crm.zip
  mv X2Engine-4.2.1/x2engine x2crm
  chown -R www-data:www-data x2crm
  apache_install
  apache_default_vhost x2crm.conf $INSTALL_PATH/x2crm/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 30M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/x2crm_hooks.sh
  mkdir -p /CL/hooks/
  mv x2crm_hooks.sh /CL/hooks/startup.sh
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
