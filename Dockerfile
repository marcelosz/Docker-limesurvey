FROM php:7.0-apache

MAINTAINER marcelosz

ENV LS_URI https://www.limesurvey.org/stable-release?download=2209:limesurvey301%20171228targz
ENV LS_SHA256 cee1cccf40bd53470a68a9ddfb560599781b7eb20ed7da2feddf76e75ec2bf55
ENV LS_TARBALL limesurvey.tar.gz
ENV WWW_DIR /var/www/html

RUN apt-get update && apt-get clean


#RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
#    docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo pdo_mysql

RUN curl --fail --show-error --location --output ${LS_TARBALL} ${LS_URI} && \
    echo "${LS_SHA256} ${LS_TARBALL}" | sha256sum --check -

RUN tar xzvf ${LS_TARBALL} -C ${WWW_DIR} && \
    rm -f ${LS_TARBALL}

WORKDIR ${WWW_DIR}
RUN chown -R www-data:www-data limesurvey
RUN chmod -R 755 ${WWW_DIR}/limesurvey/tmp
RUN chmod -R 755 ${WWW_DIR}/limesurvey/upload
RUN chmod -R 755 ${WWW_DIR}/limesurvey/application/config

VOLUME limesurvey
