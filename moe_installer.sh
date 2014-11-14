#!/bin/bash
# Script to deploy MOE at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/masterterlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
  echo "deb-src http://archive.ubuntu.com/ubuntu trusty main restricted universe" >> /etc/apt/sources.list
  apt-get update
  apt-get -y install git software-properties-common
  apt-get -y install build-essential cmake  python-pip python-dev
  apt-get -y install doxygen doxypy doxygen-dbg  libboost-all-dev libboost-python-dev
  apt-get -y install ipython ipython-notebook
  apt-get -y build-dep python-numpy python-scipy
  apt-get -y install mongodb
  cd $INSTALL_PATH
  git clone https://github.com/Yelp/MOE.git
  cd MOE
  pip install -r requirements.txt
  python setup.py install
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/moe_hooks.sh
	mkdir -p /CL/hooks/
	mv moe_hooks.sh /CL/hooks/startup.sh
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
