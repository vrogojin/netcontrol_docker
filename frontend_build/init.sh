#!/bin/bash

while [ ! -f /usr/share/shared_keys/frontend_authorized_keys ];
do
    sleep 1
done

su - net_control -c "mkdir -p /home/net_control/.ssh/ && cp /usr/share/shared_keys/frontend_authorized_keys /home/net_control/.ssh/authorized_keys"
chmod 0777 /home/net_control/.ssh && chmod 0600 /home/net_control/.ssh/authorized_keys

#mkdir -p /usr/share/shared_keys
#chown :net_control /usr/share/shared_keys
#chmod 0770 /usr/share/shared_keys
chmod 0700 /home/net_control/.ssh 
su - net_control -c "ssh-keygen -t rsa -N \"\" -f /home/net_control/.ssh/id_rsa"
cp /home/net_control/.ssh/id_rsa /var/www/html/net_control/id_rsa
chmod 0600 /var/www/html/net_control/id_rsa
su - net_control -c "chmod 0600 /home/net_control/.ssh/id_rsa && chmod 0644 /home/net_control/.ssh/id_rsa.pub"
su - net_control -c "cp /home/net_control/.ssh/id_rsa.pub /usr/share/shared_keys/backend_authorized_keys"

chown :net_control /var/www/html/net_control && chmod g+rwx /var/www/html/net_control

su - net_control -c "git clone https://github.com/vrogojin/netcontrol_frontend.git /home/net_control/git_netcontrol_frontend"
su - net_control -c "cd /home/net_control/git_netcontrol_frontend && git pull" && \
    cp -r /home/net_control/git_netcontrol_frontend/* /var/www/html/net_control && \
    chown -R www-data /var/www/html/net_control && \
    

service ssh restart
service apache2 stop && chmod 777 /var/log && chmod -R 777 /tmp && usermod -aG sudo www-data && /usr/sbin/apache2ctl -D FOREGROUND
