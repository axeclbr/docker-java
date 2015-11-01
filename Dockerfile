FROM axeclbr/debian

ENV DEBIAN_FRONTEND noninteractive

# Install Java.
RUN \
   apt-get -y update && apt-get -y upgrade && \
   apt-get -y install wget && \
   wget \
     --no-check-certificate \
     --no-cookies \
     --header "Cookie: oraclelicense=accept-securebackup-cookie" \
     http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz \
     --directory-prefix=/opt/ && \
   cd /opt && \
   tar xvzf jdk-8u60-linux-x64.tar.gz && \
   rm jdk-8u60-linux-x64.tar.gz && \
   ln -s /opt/jdk1.8.0_60/jre/bin/java /usr/local/bin/java && \
   rm -rf /var/lib/apt/lists/*;

ENV JAVA_HOME /opt/jdk1.8.0_60

CMD ["/bin/bash"]
