#!/bin/bash
# Script to deploy Codiad at Terminal.com

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
  cd $INSTALL_PATH
  wget https://github.com/Codiad/Codiad/archive/v.2.4.2.zip
  unzip v.2.4.2.zip && rm v.2.4.2.zip
  mv Codiad-v.2.4.2 codiad

  # Install some plugins
  cd codiad/plugins
  wget https://github.com/Codiad/Codiad-Collaborative/archive/master.zip
  unzip master.zip && rm master.zip
  wget https://github.com/daeks/Codiad-GitAdmin/archive/master.zip
  unzip master.zip && rm master.zip
  wget https://github.com/Andr3as/Codiad-Beautify/archive/master.zip
  unzip master.zip && rm master.zip
  wget https://github.com/daeks/Codiad-Together/archive/master.zip
  unzip master.zip && rm master.zip
  wget https://github.com/Fluidbyte/Codiad-Terminal/archive/master.zip
  unzip master.zip && rm master.zip

  # Finish installation
  cd $INSTALL_PATH
  chown -R www-data:www-data codiad
  apache_install
  apache_default_vhost codiad.conf $INSTALL_PATH/codiad/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 50M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 64M/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/codiad_hooks.sh
  mkdir -p /CL/hooks/
  mv codiad_hooks.sh /CL/hooks/startup.sh
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
