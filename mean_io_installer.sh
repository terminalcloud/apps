#!/bin/bash
# Script to deploy Mean.IO DevStack at Terminal.com
# https://github.com/linnovate/mean_user_experience

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	# Install nodejs, npm an mongodb
	apt-get -y install nodejs npm mongodb
	# Install bower, grunt, express, express generator and Angular
	npm install -g bower
	npm install -g grunt-cli
 	# Install Mean.IO
  npm install -g mean-cli
  #scaffold new mean.io application
  echo -e '\n' |  mean init myApp
  cd myApp
  #install npm dependencies
  npm install -g
  npm link
  #detect mean status
  mean status
  #start server
  grunt
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/meanio_hooks.sh
	mkdir -p /CL/hooks/
	mv meanio_hooks.sh /CL/hooks/startup.sh
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
