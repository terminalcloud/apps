#!/bin/bash
# Script to deploy Symfony Framework and a sample app at Terminal.com
INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	# 1 - Get prerrequisites.
	apache_install
	mysql_install
	mysql_setup symfony symfony terminal
	php5_install
	composer_install

	# 2 - Install the product
	cd $INSTALL_PATH
	apache_default_vhost sample.conf $INSTALL_PATH/Symfony-My-Blog
	#composer create-project symfony/framework-standard-edition base_sample/ "2.5.*"
	git clone https://github.com/mcapielo/Symfony-My-Blog.git
	cd $INSTALL_PATH/Symfony-My-Blog
	php app/console doctrine:database:create
	php app/console doctrine:fixtures:load
}

show(){
	#wget -q https://raw.githubusercontent.com/qmaxquique/terminal.com/master/docs/symfony.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	#edit.sh wordpress.md
	cd.sh /var/www/ ## Show the Wordpress directory
	/CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi