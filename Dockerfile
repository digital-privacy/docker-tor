FROM debian:jessie-slim

LABEL Name=Tor \
    Version=Edge

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg sudo wget unzip runit && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tor && \
    apt-get clean

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64 -O /usr/bin/confd && \
    chmod +x /usr/bin/confd && \
    mkdir -p /etc/confd/{templates,conf.d}

RUN echo "deb http://deb.torproject.org/torproject.org jessie main" > /etc/apt/sources.list.d/tor.list




COPY confd/torrc.toml /etc/confd/conf.d/torrc.toml
COPY confd/confd.toml /etc/confd/confd.toml
COPY tor/torrc.tmpl /etc/confd/templates/torrc.tmpl

EXPOSE 9050

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chown -R debian-tor:debian-tor /etc/tor
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
