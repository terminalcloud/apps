#!/bin/bash
# Script to deploy Wallabag at Terminal.com

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
	composer_install
	mysql_install
	mysql_setup sugarcrm sugarcrm terminal
	cd $INSTALL_PATH
	wget -q http://downloads.sourceforge.net/project/sugarcrm/1%20-%20SugarCRM%206.5.X/SugarCommunityEdition-6.5.X/SugarCE-6.5.17.zip?r=&ts=1411493342&use_mirror=ufpr
	apache_install
	apache_default_vhost sugarcrm.conf $INSTALL_PATH/sugarcrm
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/sugarcrm_hooks.sh
	mkdir -p /CL/hooks/
	mv sugarcrm_hooks.sh /CL/hooks/startup.sh
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