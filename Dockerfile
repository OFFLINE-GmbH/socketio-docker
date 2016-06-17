FROM ubuntu:latest
MAINTAINER Tobias Kuendig <tobias@offline.swiss>

RUN apt-get update && apt-get -y install supervisor nodejs npm && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN /bin/mkdir /srv/logs
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data


RUN npm install --silent socket.io ioredis

WORKDIR /srv

EXPOSE 3000

CMD ["/usr/bin/supervisord"]

