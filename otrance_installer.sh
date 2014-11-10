#!/bin/bash
# Script to deploy oTranCe at Terminal.com

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
  mysql_setup otrance otrance terminal
  cd $INSTALL_PATH
  git clone https://github.com/DSB/oTranCe.git
  mv oTranCe otrance
  chown -R www-data:www-data otrance
  apache_install
  apache_default_vhost otrance.conf $INSTALL_PATH/otrance
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini
  sed -i 's/16M/32M/g' /etc/mysql/my.cnf
  service mysql restart
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/otrance_hooks.sh
  mkdir -p /CL/hooks/
  mv otrance_hooks.sh /CL/hooks/startup.sh
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
