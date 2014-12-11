#!/bin/bash
# Script to Archeologit at Terminal.com

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
