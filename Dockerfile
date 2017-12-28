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

#WORKDIR ${LS_DIR}

#VOLUME /data

#RUN rm -rf /app
#ADD limesurvey.tar.bz2 /
#RUN mv limesurvey app; \
#	mkdir -p /uploadstruct; \
#	chown -R www-data:www-data /app

#RUN cp -r /app/upload/* /uploadstruct ; \
#	chown -R www-data:www-data /uploadstruct

#RUN chown www-data:www-data /var/lib/php5

#ADD apache_default /etc/apache2/sites-available/000-default.conf
#ADD start.sh /
#ADD run.sh /

#RUN chmod +x /start.sh && \
#    chmod +x /run.sh

# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#	&& ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME /var/www/html/limesurvey
