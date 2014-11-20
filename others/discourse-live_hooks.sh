#!/bin/bash

name="discourse-live"

export PATH=$PATH:/srv/cloudlabs/scripts

# update the server IP
IP=$(ip a | grep "venet0:0" | awk '{print $2}' | cut -d / -f1)

sed -i "s/terminalserverip/$(IP)/g" /opt/discourse-1.1.0-0/apps/discourse/htdocs/config/database.yml
sed -i "s/terminalserverip/$(IP)/g" /opt/discourse-1.1.0-0/apps/discourse/htdocs/config/discourse.conf


# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/


# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://$(hostname)-8080.terminal.com/guacamole/client.xhtml?id=c%2FDesktop"><b>Check your installation here!</b></a></p>
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
cat | /srv/cloudlabs/scripts/run_in_term.js      << EOF
/opt/discourse-1.1.0-0/ctlscript.sh start
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

