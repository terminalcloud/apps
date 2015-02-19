#!/bin/bash

name="elk"

export PATH=$PATH:/srv/cloudlabs/scripts

# Configuring Apps:
HOSTNAME=$(hostname)
sed -i "s/elasticsearch\:.*/elasticsearch: \"http\:\/\/$HOSTNAME\-9200\.terminal\.com\"\,/g" /var/www/html/kibana/config.js
sed -i "s/http.cors.allow-origin\:.*/http.cors.allow-origin\:\ \"http\:\/\/$HOSTNAME\-80\.terminal\.com\" /g" /etc/elasticsearch/elasticsearch.yml

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/

# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://$(hostname)-80.terminal.com/kibana"><b>See the Kibana interface here!</b></a></p>
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
echo | /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

cat | /srv/cloudlabs/scripts/run_in_term.js	 << _EOF_
service logstash stop; service elasticsearch restart; service apache2 restart; service logstash start
_EOF_