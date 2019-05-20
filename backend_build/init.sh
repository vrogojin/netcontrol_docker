#!/bin/bash

chown -R net_control:net_control /home/net_control
#su - net_control -c "git clone http://combio.abo.fi/scm/git/netcontrol /home/net_control/git_net_control && cd /home/net_control/git_net_control && git pull && cp -r /home/net_control/git_net_control/* /home/net_control && chmod 0777 /home/net_control/*.sh && chmod 0777 /home/net_control/*.and"
su - net_control -c "git clone https://github.com/vrogojin/netcontrol.git /home/net_control/git_net_control && cd /home/net_control/git_net_control && git pull && cp -r /home/net_control/git_net_control/* /home/net_control && chmod 0777 /home/net_control/*.sh && chmod 0777 /home/net_control/*.and"


mv /home/net_control/NetCon4BioMed /usr/local/share/anduril-bundles

su - net_control -c "mkdir -p /home/net_control/.ssh/"

chown :net_control /usr/share/shared_keys
chmod 0770 /usr/share/shared_keys
chmod 0700 /home/net_control/.ssh 
su - net_control -c "ssh-keygen -t rsa -N \"\" -f /home/net_control/.ssh/id_rsa; cp /home/net_control/.ssh/id_rsa.pub /usr/share/shared_keys/frontend_authorized_keys && chmod 0600 /home/net_control/.ssh/id_rsa && chmod 0644 /home/net_control/.ssh/id_rsa.pub"

while [ ! -f /usr/share/shared_keys/backend_authorized_keys ];
do
    sleep 1
done

su - net_control -c "cp /usr/share/shared_keys/backend_authorized_keys /home/net_control/.ssh/authorized_keys"

su - net_control -c "cd /home/net_control/git_net_control && git pull && cp -r /home/net_control/git_net_control/* /home/net_control && chmod 0777 /home/net_control/*.sh && chmod 0777 /home/net_control/*.and; cp /var/lib/version.txt /home/net_control/version.txt"

su - net_control -c "mkdir -p /home/net_control/net_control"

service ssh restart
#service ssh stop
#/usr/sbin/sshd -d

service postgresql start

export running=true

trap "running=false;exit 0" SIGTERM SIGINT

while [ $running ]
do
    sleep 1s
done
