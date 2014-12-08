#!/bin/bash
# Script to deploy Imbers at Terminal.com

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
	rvm install 2.1.1
	rvm use 2.1.1
	rvm rubygems current
	apt -y install postgresql redis-server
	wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
	echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
	apt-get update
	apt-get -y install neo4j
	git clone https://github.com/52unicorns/imbers-backend.git
	cd imbers-backend
	cp .env.sample .env
	echo "Now go and edit the $INSTALL_PATH/imbers-backend/.env file in other terminal and back here when it's done"
	read
	apt-get -y install build-essential libpq-dev postgresql-contrib-9.3
	gem install bundler
	gem install rake
	gem install i18n
	bundle install
	# nohup foreman start &

	#Frontend
	cd $INSTALL_PATH
	git clone https://github.com/52unicorns/imbers-www.git
	apt-get -y install nodejs
	cp .env.sample .env
	echo "Now go and edit the $INSTALL_PATH/imbers-www/.env file in other terminal and back here when it's done"
	read
	npm install
	#npm start


}

#Postgres Fix (If your template DB is not in UTF8 )
#postgres=# update pg_database set datallowconn = TRUE where datname = 'template0';
#UPDATE 1
#postgres=# \c template0
#You are now connected to database "template0" as user "postgres".
#template0=# update pg_database set datistemplate = FALSE where datname = 'template1';
#UPDATE 1
#template0=#  drop database template1;
#DROP DATABASE
#template0=#  create database template1 with template = template0 encoding = 'UTF8';
#CREATE DATABASE
#template0=# update pg_database set datistemplate = TRUE where datname = 'template1';
#UPDATE 1
#template0=#  \c template1
#You are now connected to database "template1" as user "postgres".
#template1=#  update pg_database set datallowconn = FALSE where datname = 'template0';
#UPDATE 1
#template1=# \q



show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/imbers_hooks.sh
	mkdir -p /CL/hooks/
	mv imbers_hooks.sh /CL/hooks/startup.sh
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