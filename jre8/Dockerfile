FROM alpine:3.3

MAINTAINER axeclbr <axeclbr@posteo.de>

RUN export \
    JAVA_MAJOR_VERSION="8" \
    JAVA_MINOR_VERSION="102" \
    JAVA_BUILD="b14" \
 && export \
    JAVA_VERSION="${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}" \
    JAVA_DIR="jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_MINOR_VERSION}" \
    GLIBC_APK_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk" \
    GLIBC_CHECKSUM="f9aa7e0bdc71fb560f99d6f447c73b5796a0ccf084e625feddbdc235e32ca722504f2e72be89fed954f6bfda3e10ed107952ae1bd5b6e1b2c6993479ff286a20" \
 && apk --update add curl \
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

CMD ["/opt/jre/bin/java", "-version"]
