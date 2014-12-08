#!/bin/bash
# Script to deploy e107 CMS at Terminal.com

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
  mysql_setup e107 e107 terminal
  apt-get -y install php5-ldap php5-imap
  php5enmod imap
  mkdir $INSTALL_PATH/e107
  cd $INSTALL_PATH/e107
  wget -O e107.zip http://sourceforge.net/projects/e107/files/e107/e107%20v2.0%20alpha2/e107_2.0_full_alpha2.zip/download
  unzip e107.zip && rm e107.zip
  cd $INSTALL_PATH
  chown -R www-data:www-data e107
  apache_install
  apache_default_vhost e107.conf $INSTALL_PATH/e107
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/e107_hooks.sh
  mkdir -p /CL/hooks/
  mv e107_hooks.sh /CL/hooks/startup.sh
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
