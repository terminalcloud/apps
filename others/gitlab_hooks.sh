#!/bin/bash
echo "external_url \"http://$(hostname)-80.terminal.com\"" > /etc/gitlab/gitlab.rb
gitlab-ctl reconfigure
gitlab-ctl start

cat > /root/info.html << EOF
<html>
<head><title>External Browser Link</title></head>
<body>
Check out your installation <a target="_blank" href="http://$(hostname)-80.terminal.com">here!</a>
</body>
</html>
EOF

cat | /srv/cloudlabs/scripts/run_in_term.js << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF