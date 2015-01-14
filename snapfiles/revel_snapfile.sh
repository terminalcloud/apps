#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Revel Framework with running examples app at Terminal.com
# https://github.com/revel/revel 

# Basic Functions
install(){
	# Includes
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
	source terlib.sh || (echo "cannot get the includes"; exit -1)

	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Install dependences 
	golang_install
	gvm install go1.2

	# Install Revel
	source ~/.profile
	go get github.com/revel/cmd/revel && echo "Revel was succesfully installed"
	}

show_sample(){
	revel run github.com/revel/revel/samples/chat &
	export PATH=$PATH:/srv/cloudlabs/scripts
	browse.sh http://localhost:9000
}

install && show_sample

#RUN: echo "Installation done"