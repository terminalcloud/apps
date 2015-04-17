#!/bin/bash
# Script to h5ai at Terminal.com
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


INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install
  pulldocker_install

  # Procedure:
  cd $INSTALL_PATH

  # Get the app docker dump
  pulldocker clue/h5ai

  # Link the data directory to the data folder outside the jail
  # (this is like exposing path with docker, using VOLUME)
  ln -s clue/h5ai/var/www data

  # Create a startup script for the App jail
  cat > clue/h5ai/start.sh << EOF
cd /var/www
supervisord -c /etc/supervisor/conf.d/supervisord.conf
EOF

  # Fix permissions
  chroot clue/h5ai chown -R www-data:www-data /var/www
  # Create startup script to launch the jail:
  echo 'echo "Starting app jail" ; chroot clue/h5ai sh start.sh&' > start.sh
  chmod +x start.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/h5ai_hooks.sh
  mkdir -p /CL/hooks/
  mv h5ai_hooks.sh /CL/hooks/startup.sh
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
