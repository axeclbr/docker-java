FROM alpine:3.3

MAINTAINER axeclbr <axeclbr@posteo.de>

ENV JDK_MAJOR_VERSION="8"
ENV JDK_MINOR_VERSION="72"
ENV JDK_VERSION="${JDK_MAJOR_VERSION}u${JDK_MINOR_VERSION}"
ENV JDK_BUILD="b15"
ENV JDK_DIR="jdk1.${JDK_MAJOR_VERSION}.0_${JDK_MINOR_VERSION}"

# Install Java.
RUN apk --update add curl \
 && mkdir /opt \
 && curl -L https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk -o /tmp/glibc-2.21-r2.apk \
 && if [ $(sha512sum /tmp/glibc-2.21-r2.apk | awk {'print $1'}) != "5fc82dc13b89ffea09cf187d5764299fc3a9ba43d75499f8b21fb975a2f4074ccfbf8c1c586316b84c6a8e476d0fce5df04d1546bf4094c531739e7a1f620d74" ]; then echo "CHECKSUM CHECK FAILED: glibc"; exit 1; fi \
 && apk add --allow-untrusted /tmp/glibc-2.21-r2.apk \
 && curl --cookie "oraclelicense=accept-securebackup-cookie" -L \
         http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_BUILD}/server-jre-${JDK_VERSION}-linux-x64.tar.gz \
         -o /opt/jre.tgz \
 && cd /opt \
 && tar xvzf jre.tgz \
 && mv /opt/${JDK_DIR}/jre /opt/jre \
 && apk del curl \
 && rm -rf \
    /opt/jre.tgz \
    /opt/${JDK_DIR} \
    /tmp/glibc-2.21-r2.apk \
    /etc/ssl \
    /var/cache/apk/*

ENV JAVA_HOME /opt/jre
ENV PATH $PATH:${JAVA_HOME}/bin

CMD ["/bin/sh"]
