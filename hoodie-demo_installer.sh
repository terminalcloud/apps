#!/bin/bash
# Script to deploy Hoodie at Terminal.com
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
	pkg_update
	system_cleanup
	basics_install

	# Install hoodie and prerrequisites:
	add-apt-repository -y ppa:chris-lea/node.js
	apt-get update
    apt-get install -y nodejs
    apt-get install -y couchdb
    service couchdb restart
    npm install -g hoodie-cli

    # Get the demo and install it
    git clone https://github.com/oliveiraa/blog-toptalCommunity.git
    hoodie new toptalCommunity
}


install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="hoodie-demo"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-6001.terminal.com"><b>Check the running demo here!</b></a></p>
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
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
cd /root
cd toptalCommunity
export COUCH_URL=http://localhost:5984
export HOODIE_BIND_ADDRESS=0.0.0.0
hoodie start -n
EOF

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

ENDOFFILE
chmod 777 /CL/hooks/startup.sh
}


if [[ -z $1 ]]; then
	install && install_hooks
elif [[ $1 == "show" ]]; then 
	install_hooks && /CL/hooks/startup.sh
else
	echo "unknown parameter specified"
fi