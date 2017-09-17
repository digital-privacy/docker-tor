FROM debian:jessie-slim

RUN apt-get update && apt-get install -y gnupg\
    && /usr/bin/gpg --keyserver pgp.mit.edu --recv 74A941BA219EC810 \
    && /usr/bin/gpg --export 74A941BA219EC810 | apt-key add - \

    && apt-get update && apt-get install -y tor sudo

RUN echo "deb     http://deb.torproject.org/torproject.org jessie main" > /etc/apt/sources.list.d/tor.list \
    && apt-get update && apt-get install -y -q wget unzip
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 -O /usr/bin/confd && \
    chmod +x /usr/bin/confd && \
    mkdir -p /etc/confd/{templates,conf.d}


COPY confd/confd.toml /etc/confd/confd.toml
COPY confd/torrc.toml /etc/confd/conf.d/torrc.toml

COPY tor/torrc.tmpl /etc/confd/templates/torrc.tmpl

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q runit

EXPOSE 9050

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
