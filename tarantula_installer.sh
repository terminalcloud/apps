#!/bin/bash
# Script to deploy Tarantula at Terminal.com
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


INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install

  # Procedure:
  yum install make gcc readline-devel zlib-devel openssl-devel libyaml redhat-lsb
  gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
  curl -L https://get.rvm.io | sudo bash -s stable --rails
  source /usr/local/rvm/scripts/rvm
  rvm install ruby-1.9.3-p551
  rvm use 1.9.3
  wget https://raw.github.com/prove/tarantula/master/vendor/installer/install.sh
  wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  rpm -i epel-release-6-8.noarch.rpm
  bash install.sh
  cd /opt/tarantula/rails
  RAILS_ENV=production rake tarantula:install
  passenger-install-apache2-module
  service httpd restart
  chkconfig httpd --add
  chkconfig --level 35 httpd on
  chkconfig mysqld --add
  chkconfig --level 35 mysqld on
  chkconfig memcached --add
  chkconfig --level 35 memcached on
  chkconfig delayed_job --add
  chkconfig --level 35 delayed_job on
  cp /opt/tarantula/rails/config/crontab /etc/cron.d/tarantula
  chown root:root /etc/cron.d/tarantula
  chmod 0644 /etc/cron.d/tarantula
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/tarantula_hooks.sh
  mkdir -p /CL/hooks/
  mv tarantula_hooks.sh /CL/hooks/startup.sh
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
