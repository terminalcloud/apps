#!/bin/bash
# Script to deploy Revel Framework with running examples app at Terminal.com
# https://github.com/revel/revel 

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

# Basics
pkg_update
system_cleanup
basics_install

# 1 Install dependences 
golang_install
gvm install go1.2

# Install Revel
go get github.com/revel/cmd/revel