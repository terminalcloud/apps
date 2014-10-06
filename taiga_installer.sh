#!/bin/bash
# Script to deploy TAIGA at Terminal.com

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
	apt-get -y autoremove --purge ruby || yum -y remove ruby
	ruby_install
	apt-get -y install nodejs || yum -y install nodejs
	gem install sass scss-lint
	cd $INSTALL_PATH
	export PATH="~/.gem/ruby/2.1.2/bin:$PATH"
	git clone https://github.com/taigaio/taiga-front.git
	cd taiga-front
	npm install -g gulp
	npm install -g bower
	npm install
	bower install
	gulp
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/taiga_hooks.sh
	mkdir -p /CL/hooks/
	mv cloud9_hooks.sh /CL/hooks/startup.sh
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