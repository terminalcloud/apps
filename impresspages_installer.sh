#!/bin/bash
# Script to deploy ImpressPages Framework at Terminal.com
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
	mysql_setup impresspages impresspages terminal
	php5_install

	# 2 - Install the product
	cd $INSTALL_PATH
	wget http://downloads.sourceforge.net/project/impresspages/ImpressPages_4_2_0.zip
	unzip ImpressPage*.zip
	apache_default_vhost impresspages.conf $INSTALL_PATH/ImpressPages
	chown -R www-data:www-data $INSTALL_PATH/ImpressPages
	sed -i 's/www/www\/html/g' /etc/apache2/apache2.conf
	service apache2 restart
}

show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/impresspages.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh impresspages.md
	cd.sh /var/www/ ## Show the served directory
	browse.sh localhost:80
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi