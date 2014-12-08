#!/bin/bash

name="xguac"

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/


# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://$(hostname)-8080.terminal.com/guacamole/client.xhtml?id=c%2FDesktop"><b>See your Desktop here!</b></a></p>
<p id="exlink"><a id="exlink" target="_blank" href="http://$(hostname)-8080.terminal.com/guacamole"><b>Guacamole Interface</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "$name.md" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html

# Update server URL in Docs
sed -i "s/terminalservername/$(hostname)/g" /root/info.html


# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
service vncserver start
service guacd start
service tomcat6 start
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
