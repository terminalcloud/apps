#!/bin/bash
# Script to deploy treefrog at Terminal.com

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
  apt-get -y install libqt4-sql-mysql libqt4-sql-psql build-essential qt4-qmake
  wget http://downloads.sourceforge.net/project/treefrog/src/treefrog-1.7.8.tar.gz
  tar -xzf treefrog-1.7.8.tar.gz
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/treefrog_hooks.sh
	mkdir -p /CL/hooks/
	mv treefrog_hooks.sh /CL/hooks/startup.sh
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
