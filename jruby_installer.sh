#!/bin/bash
# Script to deploy Mahara at Terminal.com

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
	ruby_install
	rvm install jruby
	rvm use jruby
	# Getting the sample app and compiling to war
	git clone https://github.com/wizardbeard/jruby_on_rails_sample_app.git
	cd jruby_on_rails_sample_app
	bundle
	rake assets:precompile
	warble executable war


}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/mahara_hooks.sh
	mkdir -p /CL/hooks/
	mv mahara_hooks.sh /CL/hooks/startup.sh
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