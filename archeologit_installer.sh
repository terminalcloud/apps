#!/bin/bash
# Script to Archeologit at Terminal.com
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
  pulldocker clue/archeologit


  # Create a startup script for the App jail
  cat > clue/archeologit/start.sh << EOF
cd /home/archeologit/ArcheoloGit
./run.sh /data && python3 -m http.server 8000
EOF

  # Fix permissions
  chroot clue/archeologit chown -R archeologit:archeologit /home/archeologit/

  # Create startup script
cat > start.sh << EOF
pkill -u 1000
rm -r clue/archeologit/data || true
clear
mkdir clue/archeologit/data
read -p 'Enter the https clone address of the git repository to be analyzed: ' repo
git clone $repo clue/archeologit/data/.
chroot clue/archeologit chown -R archeologit:archeologit /data
echo 'starting app jail'
chroot --userspec=archeologit clue/archeologit bash /start.sh
EOF

  chmod +x start.sh
}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/archeologit_hooks.sh
  mkdir -p /CL/hooks/
  mv archeologit_hooks.sh /CL/hooks/startup.sh
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
