#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
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
	#apt-get -y install php5 php-pear php5-gd php5-mcrypt php5-curl
	composer_install
	
	cd $INSTALL_PATH
	git clone https://github.com/hhvm/hack-example-site.git
	cd hack-example-site
	composer update
	composer install

	cd $INSTALL_PATH
	wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
	echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
	apt-get update
	apt-get -y install hhvm

	cd $INSTALL_PATH/hack-example-site
	cp hhvm.hdf server.hdf
	cp nginx.conf /etc/nginx/sites-available/hack-example-site
	ln -s /etc/nginx/sites-available/hack-example-site /etc/nginx/sites-enabled/hack-example-site
	#rm /etc/nginx/sites-enabled/default
	sed -i 's/\/path\/to\/site/\/root\/hack-example-site/g' /etc/nginx/sites-available/
hack-example-site 
	/usr/share/hhvm/install_fastcgi.sh
	/etc/init.d/hhvm restart
	service nginx restart
}

show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/hhvm.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh hhvm.md ## Show Readme
	cd.sh $INSTALL_PATH ## Show the served directory
}


install && show

#RUN: echo "Installation done"