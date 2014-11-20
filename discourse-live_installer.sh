#!/bin/bash
# Script to deploy Discourse at Terminal.com

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

  wget https://downloads.bitnami.com/files/stacks/discourse/1.1.0-0/bitnami-discourse-1.1.0-0-linux-x64-installer.run
  chmod +x bitnami-discourse-1.1.0-0-linux-x64-installer.run
  ./bitnami-discourse-1.1.0-0-linux-x64-installer.run
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/discourse-live_hooks.sh
	mkdir -p /CL/hooks/
	mv discourse-live_hooks.sh /CL/hooks/startup.sh
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
