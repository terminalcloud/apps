#!/bin/bash

name="puer"

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/static/

# Making the file...
cat > /root/static/index.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"<b>This is server by Puer. This page will be autoreloaded if you modify it!!</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "$name.md" >> /root/static/index.html

# Closing file
cat >> /root/static/index.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/static/index.html 

# Update server URL in Docs
sed -i "s/terminalservername/$(hostname)/g" /root/static/index.html