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


export PATH=$PATH:/srv/cloudlabs/scripts

LOGFILE='/root/startup.log'
name='letschat'


######### BASE FUNCTIONS ##########

log(){
    timestamp=$(date +%Y-%m-%d-%H_%M_%S\|)
    echo "$timestamp$1" >> $LOGFILE
}

get_ram_status() {
    if [ $(uptime -p | wc -l) -eq 1 ] ; then
    log 'RAMLESS'
    return 1
    elif [ $(uptime -p | cut -d ' ' -f2) -lt 3 ] ; then
            log 'RAMLESS'
            return 1
            else
                log 'RAM'
                return 1
    fi
}


make_docs(){
    # Getting the doc and styles
    wget -q -N --timeout=10 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
    wget -q -N --timeout=10 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/


    # Making the file...
    cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://$(hostname)-5000.terminal.com"><b>Let\'s Chat login</b></a></p>
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
}

############################################


ramless(){
    log 'Executing ramless commands'
    #service mongodb start
    #sleep 20
}


app_start(){
    log 'Opening a new terminal to start the application and show logs'
    cat | /srv/cloudlabs/scripts/run_in_term.js << EOF
unset NODE_PATH
cd /root/lets-chat
/srv/cloudlabs/scripts/display.sh /root/info.html
LCB_HTTP_HOST=0.0.0.0 npm start
EOF
}


################## MAIN ######################
make_docs
[[ $(get_ram_status) ]] || ramless
app_start
##############################################