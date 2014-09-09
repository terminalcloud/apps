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
	source /usr/local/rvm/scripts/rvm
	ruby_install rails

	# Compilation
	gem install passenger
	passenger-install-nginx-module --auto --auto-download --prefix="$NGINX_PATH" --languages ruby,python,nodejs,meteor
	
	# Rails example setup and stuff
	cd $INSTALL_PATH
	gem install serious
	serious blog --public --no-git
	chmod -R 777 blog/

	# Nginx conf and server block for passenger example and start Nginx
	wget -O - https://raw.githubusercontent.com/qmaxquique/terminal.com/master/others/passenger_serious_nginx.conf > "$NGINX_PATH"/conf/nginx.conf
	"$NGINX_PATH"/sbin/nginx
}


show(){
	cd $HOME
	export PATH=$PATH:/srv/cloudlabs/scripts
	wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/docs/phusionpassenger.md
	edit.sh ~/phusionpassenger.md
	cd.sh /var/www
	start_hooks_install
	/CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi