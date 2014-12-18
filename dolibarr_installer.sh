#!/bin/bash
# Script to deploy deploy Dolibarr at Terminal.com

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
  mysql_setup dolibarr dolibarr terminal
  cd $INSTALL_PATH
  wget -O dolibarr.zip http://ufpr.dl.sourceforge.net/project/dolibarr/Dolibarr%20ERP-CRM/3.6.1/dolibarr-3.6.1.zip
  unzip dolibarr.zip && rm dolibarr.zip
  mv dolibarr-3.6.1 dolibarr
  chown -R www-data:www-data dolibarr
  apache_install
  apache_default_vhost dolibarr.conf $INSTALL_PATH/dolibarr/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/dolibarr_hooks.sh
  mkdir -p /CL/hooks/
  mv dolibarr_hooks.sh /CL/hooks/startup.sh
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
