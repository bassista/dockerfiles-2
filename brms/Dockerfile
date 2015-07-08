FROM bibryam/eap:latest
MAINTAINER Bilgin Ibryam <bibryam@redhat.com>

#BRMS Version
ENV BRMS_VERSION jboss-brms-6.1.0.GA-deployable-eap6.x.zip

ENV JAVA_OPTS -XX:MaxPermSize=256m -Xms256m -Xmx1024m

USER jboss

# Add Business Central
ADD brms/ /opt/jboss
RUN unzip -q -o -d $HOME/ $HOME/$BRMS_VERSION && rm $HOME/$BRMS_VERSION

# Add admin to management realm and brmsAdmin to application realm
RUN $EAP_HOME/bin/add-user.sh -u 'admin' -p 'pa$word1' -ro 'admin'
RUN $EAP_HOME/bin/add-user.sh -a -u 'brmsAdmin' -p 'pa$word1' -ro 'admin,analyst'

# Uses this property as git port number
EXPOSE 9418

# Uses this property as ssh git port number.
EXPOSE 8001

# Run Business Central
WORKDIR $EAP_HOME/bin/
CMD ["./standalone.sh", "-b=0.0.0.0", "--server-config=standalone-full.xml", "-bmanagement=0.0.0.0", "-Dorg.uberfire.nio.git.ssh.host=0.0.0.0"]