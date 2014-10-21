#!/bin/bash
# Script to deploy FatFree CRM at Terminal.com

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
	ruby_install
	cd $INSTALL_PATH
	echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
	git clone https://github.com/fatfreecrm/fat_free_crm.git
	# You should have the database file modified
	cp fat_free_crm/config/database.mysql.yml fat_free_crm/config/database.yml
	mysql_install
	apt-get -y install build-essential libmysqlclient-dev c
	gem install mysql2
	gem install activerecord-mysql2-adapter
	apt-get -y install libmagick++-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev libpq-dev # libyaml-de
	cd fat_free_crm
	# Modify the Gemfile to use mysql2 adapter instead of pg 
	bundle install
	rake db:create
	rake db:migrate
	rake ffcrm:setup:admin USERNAME=admin PASSWORD=t3rminal EMAIL=admin@example.com
	rake ffcrm:demo:load # Only for Demo version
	# rails server # This run from the hook script
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/vanilla_hooks.sh
	mkdir -p /CL/hooks/
	mv vanilla_hooks.sh /CL/hooks/startup.sh
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