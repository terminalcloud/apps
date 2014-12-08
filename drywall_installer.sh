#!/bin/bash
# Script to deploy NodeJS Drywall at Terminal.com

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
  cd $INSTALL_PATH
	apt-get -y install nodejs npm mongodb
  npm install grunt-cli -g
  npm install bower -g
  git clone https://github.com/jedireza/drywall.git
  cd drywall
  npm install bcrypt
  npm install
  bower install --allow-root
  mv ./config.example.js ./config.js
  echo "Set mongodb as in: https://github.com/jedireza/drywall/ setup section and press enter"
  read
  grunt
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/drywall_hooks.sh
	mkdir -p /CL/hooks/
	mv drywall_hooks.sh /CL/hooks/startup.sh
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
