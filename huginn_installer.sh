#!/bin/bash
# Script to deploy Huggin at Terminal.com
# Cloudlabs, INC. Copyright (C) 2015
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Cloudlabs, INC. - 653 Harrison St, San Francisco, CA 94107.
# http://www.terminal.com - help@terminal.com


# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
    curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
    apt-get update
    apt-get install -y nodejs runit build-essential git zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev \
    libncurses5-dev libffi-dev curl openssh-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev \
    libicu-dev logrotate python-docutils pkg-config cmake nodejs graphviz ruby-mysql libmysqlclient-dev

    # Ruby
    apt-get remove -y ruby1.8 ruby1.9
    mkdir /tmp/ruby && cd /tmp/ruby
    curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.bz2 | tar xj
    cd ruby-2.2.3
    ./configure --disable-install-rdoc
    make -j`nproc`
    make install
    gem install bundler foreman --no-ri --no-rdoc
    adduser --disabled-login --gecos 'Huginn' huginn
    # MySQL Install
    mysql_install
    mysql -uroot -proot -e"SET storage_engine=INNODB;"
    service mysql restart
    mysql_setup huginn_production huginn terminal
    mysql -uroot -proot -e"DROP DATABASE huginn_production;"
    # Repo
    cd /home/huginn
    sudo -u huginn -H git clone https://github.com/cantino/huginn.git -b master huginn
    cd /home/huginn/huginn
    sudo -u huginn -H cp .env.example .env
    sudo -u huginn mkdir -p log tmp/pids tmp/sockets
    sudo chown -R huginn log/ tmp/
    sudo chmod -R u+rwX,go-w log/ tmp/
    sudo chmod -R u+rwX,go-w log/
    sudo chmod -R u+rwX tmp/
    sudo -u huginn -H chmod o-rwx .env
    sudo -u huginn -H cp config/unicorn.rb.example config/unicorn.rb
    sudo -u huginn -H bundle install --deployment --without development test

    sudo -u huginn -H sed -i 's/DATABASE_NAME\=.*/DATABASE_NAME\=huginn_production/g' .env
    sudo -u huginn -H sed -i 's/DATABASE_USERNAME\=.*/DATABASE_USERNAME\=huginn/g' .env
    sudo -u huginn -H sed -i 's/DATABASE_PASSWORD\=.*/DATABASE_PASSWORD\=terminal/g' .env
    sudo -u huginn -H sed -i 's/\#\ RAILS_ENV.*/RAILS_ENV\=production/g' .env
    echo 'RAILS_SERVE_STATIC_FILES=true' >> .env
    # Change the config/unicorn.rb file
    sudo -u huginn -H sed -i 's/worker_processes.*/worker_processes\ 1/g' config/unicorn.rb
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/huginn_hooks.sh
  mkdir -p /CL/hooks/
  mv huginn_hooks.sh /CL/hooks/startup.sh
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