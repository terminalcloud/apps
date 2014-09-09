#!/bin/bash
# Script to deploy PhusionPassenger at Terminal.com

INSTALL_PATH="/var/www"
NGINX_PATH="/opt/nginx"

# Includes
wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Installation
	source ~/.rvm/scripts/rvm
	ruby_install rails

	# Compilation
	gem install passenger
	passenger-install-nginx-module --auto --auto-download --prefix="$NGINX_PATH" --languages ruby,python,nodejs,meteor
	
	# Rails example setup and stuff
	cd $INSTALL_PATH
	gem install serious
	serious blog --public --no-git

	# Nginx conf and server block for passenger example
	wget -O - https://raw.githubusercontent.com/qmaxquique/terminal.com/master/others/passenger_serious_nginx.conf > "$NGINX_PATH"/conf/nginx.conf
}

show(){

}