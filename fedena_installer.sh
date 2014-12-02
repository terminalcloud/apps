#!/bin/bash
# Script to deploy Fedena at Terminal.com

INSTALL_PATH="/opt/fedena"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install

  # Procedure:
  apt-get -y install zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev
  apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev libmysqlclient-dev
  gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
  curl -L https://get.rvm.io | bash -s stable
  source /usr/local/rvm/scripts/rvm
  echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc
  rvm install 1.8.7
  rvm use 1.8.7 --default
  gem install rails -v 2.3.5
  mysql_install terminal
  git clone https://github.com/projectfedena/fedena.git $INSTALL_PATH
  gem uninstall -i /usr/local/rvm/gems/ruby-1.8.7-head@global rake
  gem uninstall -i ~/.rvm/gems/ruby-1.8.7-head@global rake
  gem install rake -v 0.8.7
  gem install declarative_authorization -v 0.5.1
  gem install i18n -v 0.4.2
  gem install mysql
  gem install rush -v 0.6.8
  gem update --system 1.3.7
  sed -i 's/foradian/terminal/g' config/database.yml
  rake db:create
  rake db:migrate
  rake fedena:plugins:install_all
  chmod +x script/*
  # start the server with script/server
  script/server -d # deatached version
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/fedena_hooks.sh
  mkdir -p /CL/hooks/
  mv fedena_hooks.sh /CL/hooks/startup.sh
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
