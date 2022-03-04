# Updated by Marcelo Souza on 2022/03/03
FROM php:8.1-apache

#ENV LS_URI=https://www.limesurvey.org/stable-release?download=2549:limesurvey3173%20190429targz
ENV LS_URI https://download.limesurvey.org/latest-stable-release/limesurvey5.3.2+220302.zip
ENV LS_SHA256 f9059c21ab25899348d195110c5c954879067fac58d7e2da4c745bde107b2913
ENV LS_ZIP limesurvey.zip
ENV WWW_DIR /var/www/html
ENV LS_DIR survey

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    unzip && \
    apt-get clean

RUN curl --fail --show-error --location --output ${LS_ZIP} ${LS_URI} && \
    echo "${LS_SHA256} ${LS_ZIP}" | sha256sum --check -

#RUN tar xzvf ${LS_TARBALL} -C ${WWW_DIR} && \
#    rm -f ${LS_TARBALL}

RUN unzip ${LS_ZIP} -C ${WWW_DIR} && \
    rm -f ${LS_ZIP}

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
