#!/bin/bash
# Script to deploy Padrino at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Backend:
	cd $INSTALL_PATH
	gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
	curl -L get.rvm.io | bash -s stable # Requires Basics
	source /usr/local/rvm/scripts/rvm
	echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
	rvm install 2.1.2
  rvm docs generate-ri
	rvm use 2.1.2
	rvm rubygems current
	source .bashrc
  gem install padrino
  padrino g project myapp -d datamapper -b
  cd myapp
  padrino g admin
  padrino rake dm:migrate seed
  #padrino start
}



show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/padrino_hooks.sh
	mkdir -p /CL/hooks/
	mv padrino_hooks.sh /CL/hooks/startup.sh
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
