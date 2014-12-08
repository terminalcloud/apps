#!/bin/bash
# Script to deploy Laverna Notes at Terminal.com
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
	apache_install
	cd "$INSTALL_PATH"
	git clone -b gh-pages https://github.com/Laverna/static-laverna
	mv static-laverna/ laverna
    apache_default_vhost laverna.conf $INSTALL_PATH/laverna/
}


show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/laverna.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh laverna.md
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