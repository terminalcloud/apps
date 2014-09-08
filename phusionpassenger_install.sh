#!/bin/bash
# Script to deploy PhusionPassenger at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# 

	# Installation
	apt-get -y install ruby rake
	wget http://s3.amazonaws.com/phusion-passenger/releases/passenger-4.0.50.tar.gz
	mkdir -p /opt/passenger
	cd /opt/passenger
	tar -xzf ~/passenger-4.0.50.tar.gz
	apt-get -y install build-essential libcurl4-openssl-dev libssl-dev zlib1g-dev ruby-dev
	/usr/bin/gem install rack
	cd /opt/passenger/passenger*

	# Compilation
	./bin/passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx --languages ruby,python,nodejs,meteor
	
	# Rails example setup
	apt-get install ruby-sequel
	gem install rails
	cd $INSTALL_PATH


_____

	/opt/nginx/sbin/nginx -c /opt/nginx/conf/nginx.conf

	DocumentRoot=$(/usr/bin/passenger-config --root) # Take note of this crap
	sed -i "s/\/usr\/share\/nginx\/html/etc/nginx/$DocumentRoot/g" /etc/nginx/sites-enabled/default

}