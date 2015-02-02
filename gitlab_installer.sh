#!/bin/bash
# Script to deploy GitLab at Terminal.com

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
	debconf-set-selections <<< "postfix postfix/mailname string terminal.com"
	debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
	apt-get -y install postfix
	wget https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.7.2-omnibus.5.4.2.ci-1_amd64.deb
	apt-get -y install openssh-server
	dpkg -i gitlab_7.7.2-omnibus.5.4.2.ci-1_amd64.deb
	gitlab-ctl stop
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/others/gitlab_hooks.sh
	mkdir -p /CL/hooks
	mv gitlab_hooks.sh /CL/hooks/startup.sh
	chmod +x /CL/hooks/startup.sh

	cat > /usr/local/bin/gitlab-domain-update << EOF
#!/bin/bash
if [[ \$1 == "" ]]
then echo "external_url \"http://\$(hostname)-80.terminal.com\"" > /etc/gitlab/gitlab.rb
else
echo "external_url \"\$1\"" > /etc/gitlab/gitlab.rb
fi
gitlab-ctl reconfigure
EOF
    chmod +x /usr/local/bin/gitlab-domain-update
}

show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/gitlab.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	cd.sh /root ## Show the served directory
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi