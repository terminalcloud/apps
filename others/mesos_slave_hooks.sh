#!/bin/bash

name="mesos_slave"

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/others/mesos_slave_cfg.sh && mv mesos_slave_cfg.sh /root/

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
markdown "$name.md" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html 


# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
bash /root/mesos_slave_cfg.sh
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF