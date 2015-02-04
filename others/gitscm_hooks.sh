#!/bin/bash

name="gitscm"

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/

# Create init file
touch /etc/lighttpd/htdigest
cat > /root/init.sh << EOF
echo "GitSMC initial configuration"
echo -n "Please enter your first GIT user and press [ENTER]: "
read user
git-adduser \$user
service lighttpd restart
EOF

chmod +x /root/init.sh

# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://git-scm.com/doc"><b>Git Documentation</b></a></p>
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

# Open a new terminal
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/root/init.sh
EOF
# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF