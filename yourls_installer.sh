#!/bin/bash
# Script to deploy YOURLS at Terminal.com
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
	# 1 - Get prerrequisites.
	apache_install
	mysql_install
	mysql_setup yourls yourls terminal
	php5_install

	# 2 - Install the product
	cd $INSTALL_PATH
	wget https://github.com/YOURLS/YOURLS/archive/1.7.zip
	unzip 1.7.zip
	apache_default_vhost yourls.conf $INSTALL_PATH/YOURLS-1.7
	sed -i 's/None/All/g' /etc/apache2/apache2.conf
	cd $INSTALL_PATH/YOURLS-1.7 
	cp user/config-sample.php user/config.php
	sed -i 's/your\ db\ user\ name/yourls/g' user/config.php
	sed -i 's/your\ db\ password/terminal/g' user/config.php
	sed -i 's/username/admin/g' user/config.php
	chown -R www-data:www-data $INSTALL_PATH/YOURLS-1.7
	start_hooks_install
	service apache2 restart

	# Reconfigure at start time
	sed -i "s/\.com/\.com\/admin/g" /CL/hooks/startup.sh
	echo "sed -i \"s/site.com/\$(hostname)-80.terminal.com/g\" $INSTALL_PATH/YOURLS-1.7/user/config.php" >> /CL/hooks/startup.sh

}

show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/yourls.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh $INSTALL_PATH/YOURLS-1.7/user/config.php ## Show config file
	edit.sh yourls.md ## Show Readme
	cd.sh /var/www/ ## Show the served directory
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi