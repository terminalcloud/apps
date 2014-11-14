#!/bin/bash
# Script to deploy Discourse at Terminal.com

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
  gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
  curl -L get.rvm.io | bash -s stable
  source /usr/local/rvm/scripts/rvm
  cd $INSTALL_PATH
  echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
  rvm install 2.1.3
  rvm use 2.1.3
  rvm rubygems current
  apt-get -y install libpq-dev postgresql redis-server libmagick++-dev libxml2 libxml2-dev
  gem install bundler
  sed -i 's/5232/21001/g' /etc/postgresql/9.3/main/postgresql.conf
  sed -i 's/local/#local/g' /etc/postgresql/9.3/main/pg_hba.conf
  echo "local all postgres peer" >> /etc/postgresql/9.3/main/pg_hba.conf
  echo "local all root  peer" >> /etc/postgresql/9.3/main/pg_hba.conf
  echo "local all all  peer" >> /etc/postgresql/9.3/main/pg_hba.conf
  echo "host  all all 127.0.0.1/32  trust" >> /etc/postgresql/9.3/main/pg_hba.conf
  service postgresql restart
  git clone https://github.com/discourse/discourse.git
  cd discourse
  gem install bundler
  bundle install
  bundle exec rake db:create db:migrate db:test:prepare db:seed_fu
  bundle exec rake autospec
  bundle exec rails server
}


show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/discourse_hooks.sh
  mkdir -p /CL/hooks/
  mv discourse_hooks.sh /CL/hooks/startup.sh
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
