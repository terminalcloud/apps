#!/bin/bash
# Script to deploy Wordpress at Terminal.com

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
	mysql_setup wordpress wordpress terminal
	cd $INSTALL_PATH
  wget http://wordpress.org/latest.tar.gz
  tar xzvf latest.tar.gz && rm latest.tar.gz
	chown -R www-data:www-data wordpress
	apache_install
	apache_default_vhost wordpress.conf $INSTALL_PATH/wordpress
	sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 25M/g' /etc/php5/apache2/php.ini
	sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
	sed -i 's/memory_limit\ \=\ 128M/memory_limit\ \=\ 256M/g' /etc/php5/apache2/php.ini

  # 3 - Configuring...
  cd $INSTALL_PATH/wordpress
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/wordpress/g" wp-config.php
  sed -i "s/username_here/wordpress/g" wp-config.php
  sed -i "s/password_here/terminal/g" wp-config.php

  mkdir $INSTALL_PATH/wordpress/wp-content/uploads
  chown -R www-data:www-data $INSTALL_PATH/wordpress

	service apache2 restart

  # 4 - Install wp-cli
  cd /root
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
  wget https://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash
  mv wp-completion.bash .wp-completion.bash
  echo "source .wp-completion.bash" >> .bashrc
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/wordpress_hooks.sh
	mkdir -p /CL/hooks/
	mv wordpress_hooks.sh /CL/hooks/startup.sh
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
