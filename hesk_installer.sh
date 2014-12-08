#!/bin/bash
# Script to deploy Hesk at Terminal.com

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
  mysql_setup hesk hesk terminal
  cd $INSTALL_PATH
  mkdir hesk && cd hesk
  wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/hesk.zip
  unzip hesk.zip && rm hesk.zip
  cd $INSTALL_PATH
  chown -R www-data:www-data hesk
  cp hesk/config/config.dist.php hesk/config/config.php
  apache_install
  apache_default_vhost hesk.conf $INSTALL_PATH/hesk/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 30M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/hesk_hooks.sh
  mkdir -p /CL/hooks/
  mv hesk_hooks.sh /CL/hooks/startup.sh
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
