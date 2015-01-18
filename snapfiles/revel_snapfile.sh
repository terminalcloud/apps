#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Revel Framework with running examples app at Terminal.com
# https://github.com/revel/revel 

# Basic Functions
install(){
	# Includes
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
	source terlib.sh || (echo "cannot get the includes"; exit -1)

	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Install dependences 
	golang_install
	gvm install go1.2

	# Install Revel
	source ~/.profile
	go get github.com/revel/cmd/revel && echo "Revel was succesfully installed"
	}

show_sample(){
	revel run github.com/revel/revel/samples/chat &
	export PATH=$PATH:/srv/cloudlabs/scripts
	browse.sh http://localhost:9000
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="revel"

export PATH=\$PATH:/srv/cloudlabs/scripts

# Update server URL in config
# sed -i "s/terminalservername/\$(hostname)/g" ...


# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"\$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/

# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />

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

# Open a new terminal
#echo | /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && show_sample && install_hooks

#RUN: echo "Installation done"