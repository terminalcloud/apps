#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
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
  cd ${INSTALL_PATH}

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
git clone ${repo} clue/archeologit/data/.
chroot clue/archeologit chown -R archeologit:archeologit /data
echo 'starting app jail'
chroot --userspec=archeologit clue/archeologit bash /start.sh
EOF

  chmod +x start.sh
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="archeologit"

export PATH=\$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"\${name}".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/


# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-8000.terminal.com"><b>Check your installation here!</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "\${name}.md" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html

# Update server URL in Docs
sed -i "s/terminalservername/\$(hostname)/g" /root/info.html

# Open a new terminal
echo 'cd /root && ./start.sh'| /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
ENDOFFILE
chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: echo "Installation done"