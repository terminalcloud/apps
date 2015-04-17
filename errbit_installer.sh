#!/bin/bash
# Script to deploy Errbit at Terminal.com
# Cloudlabs, INC. Copyright (C) 2015
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Cloudlabs, INC. - 653 Harrison St, San Francisco, CA 94107.
# http://www.terminal.com - help@terminal.com

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
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
	apt-get update
	apt-get -y --force-yes install mongodb-10gen
	apt-get -y 	install libxml2 libxml2-dev libxslt-dev libcurl4-openssl-dev libzip-dev libssl-dev
	curl -sSL https://get.rvm.io | bash -s stable
	/usr/local/rvm/bin/rvm install 1.9.3
	ruby_install
	gem install bundler
	git clone https://github.com/errbit/errbit.git
	cd errbit
	bundle install
	rake errbit:bootstrap
	echo "Errbit is now installed"
	echo "Now you please update the config.yml file with the dev url or update the deploy.rb file to send to production with capistrano"
	echo "use \"script/rails server\" to start the Errbit dev server" 
	# sed -i 's/errbit.example.com/$(hostname)-80.terminal.com/g' errbit/config/config.yml 
	# script/rails server
	# Deploy: cap deploy:setup deploy db:create_mongoid_indexes
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/errbit_hooks.sh
	mkdir -p /CL/hooks/
	mv errbit_hooks.sh /CL/hooks/startup.sh
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