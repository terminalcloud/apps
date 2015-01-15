#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Mean.JS DevStack at Terminal.com

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
	# Install nodejs, npm an mongodb
	apt-get -y install nodejs npm mongodb
	# Install bower, grunt, express, express generator and Angular
	npm install -g bower
	npm install -g grunt-cli
	npm install -g express
	npm install -g express-generator@4
	bower install --allow-root angular#1.2.26
	# Install Mean.JS
	git clone https://github.com/meanjs/mean.git meanjs
	npm install
	npm install -g yo
	npm install -g generator-meanjs

}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="mean"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-3000.terminal.com"><b>Check the application here</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "\$name.md" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html

# Update server URL in Docs
sed -i "s/terminalservername/\$(hostname)/g" /root/info.html

# Update Base URL
#sed -i "s/hostname/\$(hostname)/g" <file>

# Open a new terminal
echo "cd /root/sample && grunt"| /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: echo "Installation done"