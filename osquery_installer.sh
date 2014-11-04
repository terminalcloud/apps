#!/bin/bash
# Script to deploy osquery at Terminal.com

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
  apt-get -y install libqt4-sql-mysql libqt4-sql-psql build-essential
  cd $INSTALL_PATH
  git clone https://github.com/facebook/osquery.git
  make deps
  make
  make package
  dpkg -i $INSTALL_PATH/osquery/build/ubuntu/osquery-0.0.1-trusty.amd64.deb
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/osquery_hooks.sh
	mkdir -p /CL/hooks/
	mv osquery_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install #&& show
elif [[ $1 == "show" ]]; then
	show
else
	echo "unknown parameter specified"
fi
