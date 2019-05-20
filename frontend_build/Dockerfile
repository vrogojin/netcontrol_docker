FROM ubuntu:14.04

RUN echo FRONTEND

RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y main && add-apt-repository -y universe && \
    apt-get -y update && \
    apt-get -y install apache2 \
    php5 libapache2-mod-php5 php5-mcrypt \
    openssh-client \
    mailutils \
    git && \
    service apache2 stop
RUN sudo update-rc.d -f  apache2 remove
RUN sed -i -- 's/short_open_tag = Off/short_open_tag = On/g' /etc/php5/apache2/php.ini

RUN apt-get update && \
    apt-get -y install openssh-client \
    openssh-server && \
    service ssh stop
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd && \
    service ssh start

RUN useradd -m -s /bin/bash -u 1000 -U net_control

RUN su - net_control -c "git clone https://github.com/vrogojin/netcontrol_frontend.git /home/net_control/git_netcontrol_frontend && cd /home/net_control/git_netcontrol_frontend && git pull" && \
    mkdir -p /var/www/html/net_control && \
    cp -r /home/net_control/git_netcontrol_frontend/* /var/www/html/net_control &&  \
    chown -R www-data /var/www/html/net_control

ADD index.html /var/www/html/

COPY init.sh /var/lib/init.sh
RUN chmod 777 /var/lib/init.sh
ENTRYPOINT ["/var/lib/init.sh"]