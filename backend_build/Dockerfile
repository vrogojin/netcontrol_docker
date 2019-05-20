FROM moksiskaan-anduril

COPY version.txt /var/lib/version.txt

RUN apt-get update && apt-get -y install openssh-client openssh-server curl \
    git \
    mailutils \
    screen && \
    service ssh stop
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

RUN useradd -m -s /bin/bash -u 1000 -U net_control

#RUN su - net_control -c "git clone http://combio.abo.fi/scm/git/netcontrol /home/net_control/git_net_control && cd /home/net_control/git_net_control && git pull && cp -r /home/net_control/git_net_control/* /home/net_control && chmod 0777 /home/net_control/*.sh && chmod 0777 /home/net_control/*.and"
#RUN mv /home/net_control/NetCon4BioMed /usr/local/share/anduril-bundles

RUN pip install sympy --index-url=https://pypi.python.org/simple/

RUN echo PATH="/usr/local/share/scala/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/share/anduril/bin:/usr/local/share/anduril/utils" > /etc/environment
RUN echo ANDURIL_HOME="/usr/local/share/anduril" >> /etc/environment
RUN echo ANDURIL_BUNDLES="/usr/local/share/anduril-bundles" >> /etc/environment
RUN echo SCALA_HOME="/usr/local/share/scala" >> /etc/environment
RUN echo PYTHONPATH="/usr/local/share/anduril/python:" >> /etc/environment
RUN echo MOKSISKAAN_HOME="/opt/moksiskaan/db" >> /etc/environment
RUN echo HIBERNATE_DIR="/opt/hibernate" >> /etc/environment
#RUN echo CLASSPATH=":/opt/moksiskaan/db/etc:/opt/hibernate/lib/jpa/hibernate-entitymanager-4.3.5.Final.jar:/opt/hibernate/lib/required/hibernate-jpa-2.1-api-1.0.0.Final.jar:/opt/hibernate/lib/required/dom4j-1.6.1.jar:/opt/hibernate/lib/required/jboss-transaction-api_1.2_spec-1.0.0.Final.jar:/opt/hibernate/lib/required/jboss-logging-annotations-1.2.0.Beta1.jar:/opt/hibernate/lib/required/hibernate-core-4.3.5.Final.jar:/opt/hibernate/lib/required/javassist-3.18.1-GA.jar:/opt/hibernate/lib/required/jboss-logging-3.1.3.GA.jar:/opt/hibernate/lib/required/jandex-1.1.0.Final.jar:/opt/hibernate/lib/required/antlr-2.7.7.jar:/opt/hibernate/lib/required/hibernate-commons-annotations-4.0.4.Final.jar:/opt/hibernate/lib/optional/c3p0/hibernate-c3p0-4.3.5.Final.jar:/opt/hibernate/lib/optional/c3p0/mchange-commons-java-0.2.3.4.jar:/opt/hibernate/lib/optional/c3p0/c3p0-0.9.2.1.jar" >> /etc/environment
RUN echo CLASSPATH=":/opt/moksiskaan/db/etc:/opt/hibernate/lib/jpa/hibernate-jpa-2.0-api-1.0.1.Final.jar:/opt/hibernate/lib/required/dom4j-1.6.1.jar:/opt/hibernate/lib/required/javassist-3.12.0-GA.jar:/opt/hibernate/lib/required/antlr-2.7.6.jar:/opt/hibernate/hibernate3.jar" >> /etc/environment

RUN echo "source /etc/environment && export PATH" >> /etc/profile

COPY init.sh /var/lib/init.sh
RUN chmod 777 /var/lib/init.sh
ENTRYPOINT ["/var/lib/init.sh"]
