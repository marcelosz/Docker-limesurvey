FROM php:7.0-apache

# ENV LS_URI https://www.limesurvey.org/stable-release?download=2209:limesurvey301%20171228targz
ENV LS_URI https://www.limesurvey.org/stable-release?download=2470:limesurvey3148%20180829targz
ENV LS_SHA256 1725a1e09890c1ff4dee7afc1703478040c0b6ad7f25a60e15e16ca05053b675
ENV LS_TARBALL limesurvey.tar.gz
ENV WWW_DIR /var/www/html

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
RUN chown -R www-data:www-data limesurvey
RUN chmod -R 755 ${WWW_DIR}/limesurvey/tmp
RUN chmod -R 755 ${WWW_DIR}/limesurvey/upload
RUN chmod -R 755 ${WWW_DIR}/limesurvey/application/config

VOLUME limesurvey
