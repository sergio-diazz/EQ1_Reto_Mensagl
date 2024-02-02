#!/bin/bash
sudo apt update
sudo apt install coturn -y
sudo apt update
sudo apt install certbot -y
sudo apt update
sudo apt install pwgen -y
sudo certbot certonly --standalone -d equipo1coturn.duckdns.org -m sdiazl05@educantabria.es --agree-tos --no-eff-email -n #cambiar dominio y email
KEY=$(pwgen -s 64 1)
cd /etc
echo "listening-port=3478
tls-listening-port=5349
relay-threads=0
min-port=49152
max-port=65535
use-auth-secret
static-auth-secret=$KEY
realm=equipo1coturn.duckdns.org #cambiar dominio
syslog
cert=/etc/letsencrypt/live/equipo1coturn.duckdns.org/fullchain.pem #cambiar ruta
pkey=/etc/letsencrypt/live/equipo1coturn.duckdns.org/privkey.pem #cambiar ruta" > turnserver.conf