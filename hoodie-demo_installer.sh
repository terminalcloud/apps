#!/bin/bash
# Script to deploy Hoodie at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Installing hoodie and prerrequisites:
	add-apt-repository -y ppa:chris-lea/node.js
	apt-get update
    apt-get install -y nodejs
    apt-get install -y couchdb
    npm install -g hoodie-cli

    # Getting the demo
    git clone https://github.com/oliveiraa/blog-toptalCommunity.git hoodie-demo
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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-80.terminal.com"><b>Check the running demo here!</b></a></p>
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
echo | /srv/cloudlabs/scripts/run_in_term.js

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