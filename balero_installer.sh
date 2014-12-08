#!/bin/bash
# Script to deploy Balero CMS at Terminal.com

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
  mysql_setup balero balero terminal
  cd $INSTALL_PATH
  wget -O balero.zip https://github.com/BaleroCMS/balerocms-src/archive/master.zip
  unzip balero.zip && rm balero.zip
  mv balerocms-src-master balero
  chown -R www-data:www-data balero
  mv /var/www/balero/site/etc/balero.config.xml.blank /var/www/balero/site/etc/balero.config.xml
  apache_install
  apache_default_vhost balero.conf $INSTALL_PATH/balero/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 30M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  sed -i 's/max_execution_time\ \=\ 30/max_execution_time\ \=\ 60/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/balero_hooks.sh
  mkdir -p /CL/hooks/
  mv balero_hooks.sh /CL/hooks/startup.sh
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
