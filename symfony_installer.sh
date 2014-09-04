#!/bin/bash
# Script to deploy Symfony Framework and a sample app at Terminal.com
INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

# Basics
pkg_update
system_cleanup
basics_install

# Procedure: 
# 1 - Get prerrequisites.
apache_install
php5_install
composer_install
mysql_install
mysql_setup 

# 2 - Install the product
cd $INSTALL_PATH
composer bla bla bla
