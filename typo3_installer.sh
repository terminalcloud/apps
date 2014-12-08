#!/bin/bash
# Script to deploy Typo3 at Terminal.com

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
  mysql_setup typo3 typo3 terminal
  cd $INSTALL_PATH
  wget -O typo3.zip http://downloads.sourceforge.net/project/typo3/TYPO3%20Source%20and%20Dummy/TYPO3%206.2.7/typo3_src-6.2.7.zip
  unzip typo3.zip && rm typo3.zip
  mv typo3_src-6.2.7 typo3
  mv typo3/_.htaccess typo3/.htaccess
  touch typo3/FIRST_INSTALL
  ln -s typo3/typo3 typo3/typo3_src
  chown -R www-data:www-data typo3
  apache_install
  apache_default_vhost typo3.conf $INSTALL_PATH/typo3/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 30M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  sed -i 's/max_execution_time\ \=\ 30/max_execution_time\ \=\ 240/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/typo3_hooks.sh
  mkdir -p /CL/hooks/
  mv typo3_hooks.sh /CL/hooks/startup.sh
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
