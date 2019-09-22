FROM debian:buster-slim

LABEL Name=Tor \
    Version=Edge

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg curl wget unzip runit

RUN echo 'deb https://deb.torproject.org/torproject.org buster main \n\
    deb-src https://deb.torproject.org/torproject.org buster main \n'\
    >> /etc/apt/sources.list

RUN curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tor tor-arm deb.torproject.org-keyring && \
    apt-get clean

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64 -O /usr/bin/confd && \
    chmod +x /usr/bin/confd && \
    mkdir -p /etc/confd/{templates,conf.d}



COPY confd/torrc.toml /etc/confd/conf.d/torrc.toml
COPY confd/confd.toml /etc/confd/confd.toml
COPY tor/torrc.tmpl /etc/confd/templates/torrc.tmpl


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    chmod 755 -R /etc/tor && \
    chown -R debian-tor:debian-tor /etc/tor
RUN mkdir -p /var/lib/tor && chown -R debian-tor:debian-tor /var/lib/tor
CMD ""

ENV key=value \
    SOCKS_HOST= \
    SOCKS_PORT= \
    SOCKS_POLICY= \
    DAEMON= \
    DATADIR= \
    ORPORT= \
    NICKNAME= \
    CONTACTINFO= \
    EXIT_POLICY=

ENTRYPOINT ["/entrypoint.sh"]

USER debian-tor