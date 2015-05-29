#!/bin/bash

# Cloudlabs, INC. Copyright (C) 2015
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Cloudlabs, INC. - 653 Harrison St, San Francisco, CA 94107.
# http://www.terminal.com - help@terminal.com

name='harbor'

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/

# Updating Harbor to it latest version

cd /root/harbor
git checkout master
git pull

# Configuring Harbor Credentials

/srv/cloudlabs/scripts/browse.sh https://www.terminal.com/settings/api
echo 'Please copy your API User token, paste it below and press enter:'
read utoken
echo 'Please copy your API Access token, paste it below and press enter: (if it does not exist please generate it)'
read atoken

# Generating SSH key
echo 'Generating ssh key'
ssh-keygen -f /root/.ssh/id_rsa -P ''


# Launching Harbor by first time

cd /root/harbor
./harbor.py -u "$utoken" -a "$atoken" -p 8080 &
cd /root


# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="https://blog.terminal.com/harbor"><b>Harbor Blog Post</b></a></p>
<p id="exlink"><a id="exlink" target="_blank" href="https://github.com/terminalcloud/harbor"><b>Harbor Github Repo</b></a></p>
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
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF