#!/bin/bash
# Script to deploy Tiny Tiny RSS at Terminal.com
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

  # First, get a PostgreSQL docker dump

  pulldocker nornagon/postgres

  # Create a startup for DB jail
  echo '/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf' > nornagon/postgres/start.sh
  # Do some fixes in there
  chroot nornagon/postgres chown -R postgres /var/run/postgresql
  chroot nornagon/postgres chown -R postgres /var/lib/postgresql
  chroot nornagon/postgres chown -R postgres /etc/postgresql

  # Get the app docker dump
  pulldocker clue/ttrss

  # Create a startup script for the App jail
  cat > clue/ttrss/start.sh << EOF
cd /var/www
export DB_HOST=127.0.0.1
export DB_PORT=5432
export DB_TYPE=pgsql
export DB_PORT_5432_TCP_ADDR=5432
export DB_NAME ttrss
export DB_USER ttrss
export DB_PASS ttrss
php /configure-db.php && supervisord -c /etc/supervisor/conf.d/supervisord.conf
EOF

  # Fix permissions
  chroot clue/ttrss chown -R www-data:www-data /var/www

  # Create startup script
cat > start.sh << EOF
echo 'starting postgres jail'
chroot --userspec=postgres nornagon/postgres bash /start.sh&
sleep 5
echo 'starting app jail'
chroot clue/ttrss bash /start.sh&
EOF

  chmod +x start.sh
  # Startup script execution
  ./start.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/ttrss_hooks.sh
  mkdir -p /CL/hooks/
  mv ttrss_hooks.sh /CL/hooks/startup.sh
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
