#!/bin/bash
# Script to deploy Barkeep at Terminal.com

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
  cd $INSTALL_PATH
  apt-get -y install python-pip python-imaging
  apt-get install -y g++ build-essential libxslt1-dev libxml2-dev python-dev libmysqlclient-dev redis-server
  # Ruby SE


  ruby_install
  source .bash_rc
  gem install bundler

  git clone git://github.com/ooyala/barkeep.git ~/barkeep
  cd ~/barkeep && bundle install

  debconf-set-selections <<< "mysql-server mysql-server/root_password password ''"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ''"
  DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server

  mysqladmin -u root --password='' create barkeep
  cd ~/barkeep && ./script/run_migrations.rb

  cd ~/barkeep
  foreman export upstart upstart_scripts -a barkeep -l /var/log/barkeep -u $USER -f Procfile
  mv upstart_scripts/* /etc/init

  cp environment.prod.rb environment.rb
  cp environment.prod.sh environment.sh

  start barkeep
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/barkeep_hooks.sh
  mkdir -p /CL/hooks/
  mv barkeep_hooks.sh /CL/hooks/startup.sh
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
