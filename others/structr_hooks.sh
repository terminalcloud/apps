#!/bin/bash

name="structr"

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css

# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"href="termlib.css" />
<p id="exlink"><a id="exlink" href="http://$(hostname)-8082.terminal.com"><b>Check your installation here!</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "$name" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF


# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF