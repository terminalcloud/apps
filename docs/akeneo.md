#!/bin/bash
# Script to deploy Akeneo PM at Terminal.com

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
  mysql_setup akeneo akeneo terminal
  cd $INSTALL_PATH
  wget http://www.akeneo.com/pim-community-standard-v1.2.4-icecat.tar.gz
  tar -xzf pim-community-standard-v1.2.4-icecat.tar.gz && rm pim-community-standard-v1.2.4-icecat.tar.gz
  mv pim-community-standard-v1.2.4-icecat akeneo
  chown -R www-data:www-data akeneo
  apache_install

cat > /etc/apache2/sites-enabled/akeneo.conf << EOF
  <VirtualHost *:80>
  DocumentRoot /var/www/akeneo/web
  <Directory /var/www/akeneo/web >
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
      Require all granted
      </Directory>
</VirtualHost>
EOF


  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 512M/g' /etc/php5/apache2/php.ini
  echo "date.timezone = Etc/UTC" >> /etc/php5/apache2/php.ini
  
  sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 768M/g' /etc/php5/cli/php.ini
  echo "date.timezone = Etc/UTC" >> /etc/php5/cli/php.ini
  apt-get -y install php5-intl 
  cd $INSTALL_PATH/akeneo
  php app/console cache:clear --env=prod
  php app/console pim:install --env=prod

  service apache2 restart
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/akeneo_hooks.sh
  mkdir -p /CL/hooks/
  mv akeneo_hooks.sh /CL/hooks/startup.sh
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