#!/bin/bash
# Script to deploy wide PM at Terminal.com

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
	golang_install
	source .bashrc
	git clone https://github.com/b3log/wide.git
	cd wide
	go get -u github.com/b3log/wide
	go get -u github.com/88250/ide_stub
	go get -u github.com/nsf/gocode
	go build
	mkdir -p /root/go/bin/data/user_workspaces/admin/src/
	echo "Edit the conf/wide.json file before launch the wide"


}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/wide_hooks.sh
	mkdir -p /CL/hooks/
	mv wide_hooks.sh /CL/hooks/startup.sh
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