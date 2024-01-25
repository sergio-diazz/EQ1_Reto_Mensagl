#!/bin/bash
#Script creado por Sergio Diaz Lastra
#25/01/2024
#Instalación postgreSQL desde su repositorio, añadiendolos previamente
sudo curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /usr/share/keyrings/postgresql-key.gpg >/dev/null
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/postgresql-key.gpg arch=amd64] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib -y