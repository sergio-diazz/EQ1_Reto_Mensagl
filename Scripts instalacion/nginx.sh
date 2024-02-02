#!/bin/bash
#Script creado por Sergio Diaz Lastra
#25/01/2024
#Instalación nginx con certificados, actualización del archivo de configuración de matrix.conf y creando los archivos para federar
scheme='$scheme'
host='$host'
server_addr='$server_addr'
apt-get update
apt-get install nginx -y
apt-get install python3-certbot-nginx -y
systemctl stop nginx.service
certbot certonly --standalone -d matrix.equipo1msql.duckdns.org -m sdiazl05@educantabria.es --agree-tos --no-eff-email -n #cambiar dominio y email
cd /etc/nginx/conf.d
echo "server {
    ssl_certificate /etc/letsencrypt/live/matrix.equipo1msql.duckdns.org/fullchain.pem; #cambiar carpeta
    ssl_certificate_key /etc/letsencrypt/live/matrix.equipo1msql.duckdns.org/privkey.pem; #cambiar carpeta
    include /etc/letsencrypt/options-ssl-nginx.conf; 
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; 

    # For the federation port
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    listen 8448 http2 ssl default_server;
    listen [::]:8448 http2 ssl default_server;

    server_name matrix.equipo1msql.duckdns.org; #editar dominio

    location ~ ^(/_matrix|/_synapse/client) {
        # note: do not add a path (even a single /) after the port in `proxy_pass`,
        # otherwise nginx will canonicalise the URI and cause signature verification
        # errors.
        proxy_pass http://10.100.50.77:8008; #editar ip
        proxy_set_header X-Forwarded-For 10.100.50.77; #editar ip
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_bind $server_addr;

        # Nginx by default only allows file uploads up to 1M in size
        # Increase client_max_body_size to match max_upload_size defined in homeserver.yaml
        client_max_body_size 50M;

    proxy_http_version 1.1;
    }

    location /.well-known/matrix/ {
            root /var/www/html/;
            default_type application/json;
            add_header Access-Control-Allow-Origin *;

    }
}" > matrix.conf
systemctl start nginx.service
cd /var/www/html/
mkdir -p .well-known/matrix
cd .well-known/matrix
echo "{
    "m.server": "matrix.equipo1msql.duckdns.org:443" #cambiar dominio
}" > server
