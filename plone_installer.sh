#!/bin/bash
# Script to deploy Plone 4.3.3 at Terminal.com

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
	wget https://launchpad.net/plone/4.3/4.3.3/+download/Plone-4.3.3-UnifiedInstaller.tgz
	tar -xzf Plone-4.3.3-UnifiedInstaller.tgz
	apt-get -y install build-essential python-dev libxml2-dev libssl-dev libxslt1-dev libbz2-dev \
	zlib1g-dev python-setuptools python-dev libjpeg62-dev libreadline-gplv2-dev python-imaging \
	wv poppler-utils
	cd Plone-4.3.3-UnifiedInstaller && ./install.sh standalone


}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/plone_hooks.sh
	mkdir -p /CL/hooks/
	mv plone_hooks.sh /CL/hooks/startup.sh
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