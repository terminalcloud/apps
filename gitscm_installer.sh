#!/bin/bash
# Script to deploy Git SCM with http/s support at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
	apt-get -y install git lighttpd apache2-utils
    cat > /etc/lighttpd/conf-available/50-gitrepo.conf << EOF
server.modules += ( "mod_setenv", "mod_rewrite" )
alias.url += ( "/git" => "/usr/lib/git-core/git-http-backend" )
\$HTTP["scheme"] == "http" {
    url.rewrite-once = ( "^/git$" => "/git/" )
    \$HTTP["url"] =~ "^/git/" {
        cgi.assign = ( "" => "" )
        setenv.add-environment = (
            "GIT_HTTP_EXPORT_ALL" => "",
            "GIT_PROJECT_ROOT" => "/var/cache/git"
        )
        auth.backend = "htdigest"
        auth.backend.htdigest.userfile = "/etc/lighttpd/htdigest"
        auth.require = ( "" => (
                "method" => "digest",
                "realm" => "git",
                "require" => "valid-user"
        ))
    }
}
EOF

    cat > /usr/local/bin/git-adduser << _EOF_
#!/bin/bash
[ -z \$1 ] && echo "Usage: git-adduser <username>" && exit 0
user=\$1
/usr/bin/htdigest /etc/lighttpd/htdigest git \$user
_EOF_

    cat > /usr/local/bin/git-deluser << _EOF_
#!/bin/bash
[ -z \$1 ] && echo "Usage: git-deluser <username>" && exit 0
user=\$1
sed -i "/\$user\:/d" /etc/lighttpd/htdigest
_EOF_

    cat > /usr/local/bin/git-addrepo << _EOF_
#!/bin/bash
[ -z \$1 ] && echo "Usage: git-addrepo <repo_name>" && exit 0
repo=\$1
git init --bare /var/cache/git/\$repo
chown -R www-data /var/cache/git/\$repo
_EOF_

    chmod +x /usr/local/bin/git-*

    lighty-enable-mod auth cgi ssl gitrepo
    rm /etc/lighttpd/conf-enabled/10-ssl.conf

    mkdir -p /var/cache/git/

    service lighttpd restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/gitscm_hooks.sh
	mkdir -p /CL/hooks/
	mv gitscm_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi