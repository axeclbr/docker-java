FROM alpine:3.3

MAINTAINER axeclbr <axeclbr@posteo.de>

ENV JAVA_MAJOR_VERSION 8
ENV JAVA_MINOR_VERSION 72
ENV JAVA_VERSION       ${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}
ENV JAVA_BUILD         b15
ENV JAVA_DIR           jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_MINOR_VERSION}

ENV GLIBC_APK_URL      https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk
ENV GLIBC_CHECKSUM     5fc82dc13b89ffea09cf187d5764299fc3a9ba43d75499f8b21fb975a2f4074ccfbf8c1c586316b84c6a8e476d0fce5df04d1546bf4094c531739e7a1f620d74

# Install Java.
RUN apk --update add curl \
 && mkdir /opt \
 && curl -L $GLIBC_APK_URL -o /tmp/glibc.apk \
 && if [ $(sha512sum /tmp/glibc.apk | awk {'print $1'}) != $GLIBC_CHECKSUM ]; then echo "CHECKSUM CHECK FAILED: glibc"; exit 1; fi \
 && apk add --allow-untrusted /tmp/glibc.apk \
 && curl --cookie "oraclelicense=accept-securebackup-cookie" -L \
         http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-${JAVA_BUILD}/server-jre-${JAVA_VERSION}-linux-x64.tar.gz \
         -o /opt/jre.tgz \
 && cd /opt \
 && tar xvzf jre.tgz \
 && mv /opt/${JAVA_DIR}/jre /opt/jre \
 && apk del curl \
 && rm -rf \
    /opt/jre.tgz \
    /opt/${JAVA_DIR} \
    /tmp/glibc.apk \
    /etc/ssl \
    /var/cache/apk/*

ENV JAVA_HOME /opt/jre
ENV PATH $PATH:${JAVA_HOME}/bin

CMD ["/bin/sh"]
