#!/bin/bash
#Script creado por Sergio Diaz Lastra
#25/01/2024
#Cambiar el archivo de configuración de turn en el servidor matrix
cd /etc/matrix-synapse/conf.d
echo "turn_uris: [ "turns:equipo1coturn.duckdns.org?transport=udp", "turns:equipo1coturn.duckdns.org?transport=tcp" ] #cambiar dominio
turn_shared_secret: "0OzqH2XmIV6BiWvultmhG679vVHqtdJvserJbZrJcdlTVFpwxGXzaxzzW1OnKu59" #poner la clave que te dieron en el turn
turn_user_lifetime: 86400000
turn_allow_guests: True" > turn.yaml
