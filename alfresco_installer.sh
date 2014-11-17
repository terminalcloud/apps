#!/bin/bash
# Script to deploy Alfresco at Terminal.com

INSTALL_PATH="/var/www"

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
  add-apt-repository ppa:jon-severinsson/ffmpeg
  apt-get update
  apt-get -y install ghostscript imagemagick ffmpeg libjpeg62 libgif4 libreoffice
  wget http://dl.alfresco.com/release/community/5.0.b-build-00092/alfresco-community-5.0.b-installer-linux-x64.bin
  chmod +x alfresco-community-5.0.b-installer-linux-x64.bin
  ./alfresco-community-5.0.b-installer-linux-x64.bin

}

show(){
  # Get the startup script
  wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/alfresco_hooks.sh
  mkdir -p /CL/hooks/
  mv alfresco_hooks.sh /CL/hooks/startup.sh
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
