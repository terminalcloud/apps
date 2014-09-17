#!/bin/bash
# Script to deploy Facebook HHVM at Terminal.com
INSTALL_PATH="/root"
set -x
# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: .
	nginx_install
	php5_install
	composer_install
	
	cd $INSTALL_PATH
	git clone https://github.com/hhvm/hack-example-site.git
	cd hack-example-site
	composer install

	cd $INSTALL_PATH
	wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
	echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
	apt-get update
	apt-get install hhvm

	cd $INSTALL_PATH/hack-example-site
	cp hhvm.hdf server.hdf
	cp nginx.conf /etc/nginx/sites-available/hack-example-site
	ln -s /etc/nginx/sites-available/hack-example-site /etc/nginx/sites-enabled/hack-example-site
	rm /etc/nginx/sites-enabled/default
	cat /etc/nginx/sites-available/hack-example-site
	read
	service hhvm-fastcgi start
	service nginx start
}

show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/hhvm.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh hhvm.md ## Show Readme
	cd.sh $INSTALL_PATH ## Show the served directory
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi