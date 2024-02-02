#!/bin/bash
#Script creado por Sergio Diaz Lastra
#25/01/2024
#Creación de usuario y base datos
createuser --pwprompt synapse
createdb --encoding=UTF8 --locale=C --template=template0 --owner=synapse synapsedb
exit
