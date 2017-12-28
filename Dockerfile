FROM ubuntu:latest

MAINTAINER marcelosz

ENV LS_DOWNLOAD_URL https://www.limesurvey.org/stable-release?download=2203:limesurvey300%20171222tarbz2

RUN apt-get update && \
	apt-get upgrade -q -y && \
	apt-get install -q -y postfix && \  
	apt-get install -q -y php7.0 php7.0-mbstring php7.0-gd php7.0-ldap php7.0-imap && \
	apt-get clean && \
  
# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
#CMD ["/start.sh"]
