FROM fedora:20
MAINTAINER Bilgin Ibryam <bibryam@redhat.com>

# Execute system update
RUN yum -y update && yum clean all

# Install packages necessary to run EAP
RUN yum -y install xmlstarlet saxon augeas bsdtar unzip java-1.7.0-openjdk-devel && yum clean all

# Create a user and group used to launch processes
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

WORKDIR /opt/jboss

USER jboss

ENV JAVA_HOME /usr/lib/jvm/java

# Add the EAP distribution to /opt
ADD . /opt/jboss
RUN unzip -q -d $HOME/ $HOME/jboss-eap-6.4.0.zip \
    && rm $HOME/jboss-eap-6.4.0.zip \
    && unzip -q -o -d $HOME/ $HOME/jboss-brms-6.1.0.GA-deployable-eap6.x.zip \
    && rm $HOME/jboss-brms-6.1.0.GA-deployable-eap6.x.zip \
    && mv $HOME/jboss-eap-6.4 $HOME/eap

ENV EAP_HOME /opt/jboss/eap
ENV JAVA_OPTS -XX:MaxPermSize=256m -Xms256m -Xmx1024m

# Add admin to management realm and brmsAdmin to application realm
RUN $EAP_HOME/bin/add-user.sh -u 'admin' -p 'pa$word1' -ro 'admin'
RUN $EAP_HOME/bin/add-user.sh -a -u 'brmsAdmin' -p 'pa$word1' -ro 'admin,analyst'

# Uses this property as git port number
EXPOSE 9418

# Uses this property as ssh git port number.
EXPOSE 8001

# The default port for deployed web applications.
EXPOSE 8080

# The Web Management Console port
EXPOSE 9990

# The port used by the Management Console and Management API
EXPOSE 9999

# Run Business Central
WORKDIR $EAP_HOME/bin/
CMD ["./standalone.sh", "-b=0.0.0.0", "--server-config=standalone-full.xml", "-bmanagement=0.0.0.0", "-Dorg.uberfire.nio.git.ssh.host=0.0.0.0"]
