#!/bin/bash
# Script to deploy deploy Simple Invoice at Terminal.com

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
  mysql_setup simpleinvoices simpleinvoices terminal
  cd $INSTALL_PATH
  wget -O simpleinvoices.zip https://raw.githubusercontent.com/terminalcloud/apps/master/others/simpleinvoices.zip
  unzip simpleinvoices.zip && rm simpleinvoices.zip
  chown -R www-data:www-data simpleinvoices
  apache_install
  apache_default_vhost simpleinvoices.conf $INSTALL_PATH/simpleinvoices
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/simpleinvoice_hooks.sh
  mkdir -p /CL/hooks/
  mv simpleinvoice_hooks.sh /CL/hooks/startup.sh
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
