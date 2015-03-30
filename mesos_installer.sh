#!/bin/bash
# Script to deploy Mesos (Stand-Alone Version) at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install
	python_install

	# Procedure: 
	apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
	DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
	CODENAME=$(lsb_release -cs)
	echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | tee /etc/apt/sources.list.d/mesosphere.list
	apt-get -y update
	apt-get -y install mesos marathon

	# Install terminalcloud python utils
	pip install terminalcloud
	# reboot
}

compile(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Compilation: 
	apt-get -y install build-essential openjdk-6-jdk python-dev python-boto libcurl4-nss-dev libsasl2-dev
	apt-get -y install maven libapr1-dev libsvn-dev autoconf libtool
	git clone https://github.com/apache/mesos.git
    cd mesos
    ./bootstrap
    mkdir build
    cd build
    ../configure
    make
    make check
    make install
}



show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/mesos_standalone_hooks.sh
	mkdir -p /CL/hooks/
	mv mesos_standalone_hooks.sh /CL/hooks/startup.sh
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