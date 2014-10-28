#!/bin/bash
# Script to deploy PostgreSQL Stack at Terminal.com

INSTALL_PATH="/root/"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	postgres_install
	
	# PGWeb installation
	mkdir -p /opt/pgweb
	cd /opt/pgweb
	wget https://github.com/sosedoff/pgweb/releases/download/v0.3.0/pgweb_linux_amd64.zip
	unzip pgweb_linux_amd64.zip && rm pgweb_linux_amd64.zip
	chmod +x pgweb_linux_amd64
	ln -s /opt/pgweb/pgweb_linux_amd64 /bin/pgweb

	# PhpPGAdmin
	apt-get -y install phppgadmin || yum -y install phppgadmin
	cp /etc/apache2/conf.d/phppgadmin /etc/apache2/conf-enabled/phppgadmin.conf
	/etc/init.d/apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/postgres_hooks.sh
	mkdir -p /CL/hooks/
	mv postgres_hooks.sh /CL/hooks/startup.sh
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