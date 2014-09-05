#!/bin/bash
# Script to deploy Revel Framework with running examples app at Terminal.com
# https://github.com/revel/revel 

# Basic Functions
install(){
	# Includes
	wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
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
	nohup revel run github.com/revel/revel/samples/chat &
	export PATH=$PATH:/srv/cloudlabs/scripts
	browse.sh http://localhost:9000
}

#Main
if [[ -z $1 ]]; then
	install && show_sample
elif [[ $1 == "show" ]]; then 
	show_sample
else
	echo "unknown parameter specified"
fi