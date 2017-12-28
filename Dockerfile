FROM php:7.0-apache

MAINTAINER marcelosz

ENV LS_URI https://www.limesurvey.org/stable-release?download=2209:limesurvey301%20171228targz 
ENV LS_SHA256 cee1cccf40bd53470a68a9ddfb560599781b7eb20ed7da2feddf76e75ec2bf55 
ENV LS_TARBALL limesurvey.tar.gz
ENV WWW_DIR /var/www/html

RUN apt-get update && apt-get clean
  
RUN curl --fail --show-error --location --output ${LS_TARBALL} ${LS_URI} && \
    echo "${LS_SHA256} ${LS_TARBALL}" | sha256sum --check -

RUN tar xzvf ${LS_TARBALL} -C ${WWW_DIR} && \
    rm -f ${LS_TARBALL}

WORKDIR ${WWW_DIR}
RUN chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" limesurvey

VOLUME limesurvey
