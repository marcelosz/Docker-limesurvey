FROM ubuntu:latest

MAINTAINER marcelosz

ENV LS_URI https://www.limesurvey.org/stable-release?download=2209:limesurvey301%20171228targz 
ENV LS_SHA256 cee1cccf40bd53470a68a9ddfb560599781b7eb20ed7da2feddf76e75ec2bf55 
ENV LS_TARBALL limesurvey.tar.gz
ENV LS_ROOT_DIR /opt
ENV LS_DIR /opt/limesurvey

RUN apt-get update && apt-get install -y \
    curl \
    #postfix \
    php7.0 \
    php7.0-mbstring \
    php7.0-gd \
    php7.0-ldap \
    php7.0-imap && \
    apt clean
  
RUN curl --fail --show-error --location --output ${LS_TARBALL} ${LS_URI} && \
    echo "${LS_SHA256} ${LS_TARBALL}" | sha256sum --check --quiet - && \
    tar --extract --file ${LS_TARBALL} --directory ${LS_ROOT_DIR} && \
    rm ${LS_TARBALL}

WORKDIR ${LS_ROOT_DIR}
RUN mv lime* limesurvey && \

#WORKDIR ${LS_DIR}

#RUN mv data /data \
#    && ln --symbolic /data

#VOLUME /data

#COPY docker-entrypoint.sh /docker-entrypoint.sh
#RUN chmod 755 /docker-entrypoint.sh

#EXPOSE 7474 7473 7687

#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["neo4j"]



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

#VOLUME /app/upload

# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
