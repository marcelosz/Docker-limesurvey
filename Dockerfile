# Updated by Marcelo Souza on 2019/04/30
FROM php:7.0-apache

#ENV LS_URI https://www.limesurvey.org/stable-release?download=2470:limesurvey3148%20180829targz
ENV LS_URI=https://www.limesurvey.org/stable-release?download=2549:limesurvey3173%20190429targz
#ENV LS_SHA256 1725a1e09890c1ff4dee7afc1703478040c0b6ad7f25a60e15e16ca05053b675
ENV LS_SHA256 db4079a998f5824d8e52268530d4a522772ab668f418f7e8c677a3fb7d233daf
ENV LS_TARBALL limesurvey.tar.gz
ENV WWW_DIR /var/www/html
ENV LS_DIR survey

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev && \
    apt-get clean

RUN curl --fail --show-error --location --output ${LS_TARBALL} ${LS_URI} && \
    echo "${LS_SHA256} ${LS_TARBALL}" | sha256sum --check -

RUN tar xzvf ${LS_TARBALL} -C ${WWW_DIR} && \
    rm -f ${LS_TARBALL}

#RUN pecl install zip

#RUN docker-php-ext-enable zip

RUN docker-php-source extract && \
    docker-php-ext-configure gd && \
    docker-php-ext-configure zip && \
# Add this modules if you need them
#    docker-php-ext-configure ldap && \
#    docker-php-ext-configure imap && \
    docker-php-ext-install gd zip && \
    docker-php-source delete 

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR ${WWW_DIR}
RUN mv limesurvey ${LS_DIR}
RUN chown -R www-data:www-data ${LS_DIR}
RUN chmod -R 755 ${WWW_DIR}/${LS_DIR}/tmp
RUN chmod -R 755 ${WWW_DIR}/${LS_DIR}/upload
RUN chmod -R 755 ${WWW_DIR}/${LS_DIR}/application/config

VOLUME ${WWW_DIR}/${LS_DIR}
