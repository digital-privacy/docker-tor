#!/bin/bash
echo "Starting container..."
echo "Generating initial tor configuration with confd..."

confd -onetime -config-file /etc/confd/confd.toml;

echo "Config created."

sleep 5

echo "Confd now watching for changes..."
confd -interval 5 -config-file /etc/confd/confd.toml &

echo "Starting Tor..."
exec /usr/bin/tor -f /etc/tor/torrc
