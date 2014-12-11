#!/bin/bash
# Script to deploy Tiny Tiny RSS at Terminal.com

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
