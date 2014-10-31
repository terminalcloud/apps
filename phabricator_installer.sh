#!/bin/bash
# Script to deploy Phabricator at Terminal.com

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
	mysql_setup phabricator phabricator terminal
	cd $INSTALL_PATH
	git clone https://github.com/phacility/libphutil.git
	git clone https://github.com/phacility/arcanist.git
	git clone https://github.com/phacility/phabricator.git
	chown -R www-data:www-data *
	apache_install
	apache_default_vhost phabricator.conf /var/www/phabricator/webroot
	cat > /etc/apache2/sites-available/phabricator.conf << EOF
<VirtualHost *>
  DocumentRoot /var/www/phabricator/webroot

	<Directory "/path/to/phabricator/webroot">
	  Require all granted
	</Directory>

  RewriteEngine on
  RewriteRule ^/rsrc/(.*)     -                       [L,QSA]
  RewriteRule ^/favicon.ico   -                       [L,QSA]
  RewriteRule ^(.*)$          /index.php?__path__=$1  [B,L,QSA]
</VirtualHost>
EOF
	a2enmod rewrite
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/phabricator_hooks.sh
	mkdir -p /CL/hooks/
	mv phabricator_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install #&& show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi