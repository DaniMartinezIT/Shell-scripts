#!/bin/bash

# Comprobación de accesos perimetrales para entornos cert,build,train y prod dado un csv con los comservers de integración
TIMEOUT=1
IP_ML_CERT=***
IP_ML_BUILD=***
IP_ML_TRAIN=***
IP_ML_PROD=***
SCRIPT=$(readlink -f $0)
RUTA=`dirname $SCRIPT`


PS3='Elige una opcion: '
options=("Comprobar acceso a ML CERT" "Comprobar acceso a ML BUILD" "Comprobar acceso a ML TRAIN" "Comprobar acceso a ML PROD" "Comprobar acceso a sistemas externos" "Salir")
select opt in "${options[@]}"
do
    case $opt in
        "Comprobar acceso a ML CERT")
            echo "Comprobando acceso desde este equipo a los puertos de Millennium CERT"
    cat  $RUTA/lista_socket_FSI.csv | while read -r line
    do
SCP=$(echo $line | awk -F';' '{printf "%s", $1}' | tr -d '"')
ID=$(echo $line | awk -F';' '{printf "%s", $2}' | tr -d '"')
PROC_NAME=$(echo $line | awk -F';' '{printf "%s", $3}' | tr -d '"')
SERVICE=$(echo $line | awk -F';' '{printf "%s", $4}' | tr -d '"')
IP=$(echo $line | awk -F';' '{printf "%s", $5}' | tr -d '"')
PORT=$(echo $line | awk -F';' '{printf "%s", $6}' | tr -d '"')

if [ "$SERVICE" == "Inbound" ]
then
if [ "$PORT" == "" ]
then
echo "El canal $PROC_NAME de $SERVICE no tiene PUERTO: IGNORA"
else
if nc -w $TIMEOUT -z $IP_ML_CERT $PORT; then
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_CERT y PUERTO: $PORT ------------> OK"
else
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_CERT y PUERTO: $PORT ------------> ERROR, Codigo ($?)."
fi
fi

fi

    done
            ;;
        "Comprobar acceso a ML BUILD")
            echo "Comprobando acceso desde este equipo a los puertos de Millennium BUILD"
    cat  $RUTA/lista_socket_FSI.csv | while read -r line
    do
SCP=$(echo $line | awk -F';' '{printf "%s", $1}' | tr -d '"')
ID=$(echo $line | awk -F';' '{printf "%s", $2}' | tr -d '"')
PROC_NAME=$(echo $line | awk -F';' '{printf "%s", $3}' | tr -d '"')
SERVICE=$(echo $line | awk -F';' '{printf "%s", $4}' | tr -d '"')
IP=$(echo $line | awk -F';' '{printf "%s", $5}' | tr -d '"')
PORT=$(echo $line | awk -F';' '{printf "%s", $6}' | tr -d '"')

if [ "$SERVICE" == "Inbound" ]
then
if [ "$PORT" == "" ]
then
echo "El canal $PROC_NAME de $SERVICE no tiene PUERTO: IGNORA"
else
if nc -w $TIMEOUT -z $IP_ML_BUILD $PORT; then
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_BUILD y PUERTO: $PORT ------------> OK"
else
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_BUILD y PUERTO: $PORT ------------> ERROR, Codigo ($?)."
fi
fi

fi

    done
            ;;
        "Comprobar acceso a ML TRAIN")
            echo "Comprobando acceso desde este equipo a los puertos de Millennium TRAIN"
    cat  $RUTA/lista_socket_FSI.csv | while read -r line
    do
SCP=$(echo $line | awk -F';' '{printf "%s", $1}' | tr -d '"')
ID=$(echo $line | awk -F';' '{printf "%s", $2}' | tr -d '"')
PROC_NAME=$(echo $line | awk -F';' '{printf "%s", $3}' | tr -d '"')
SERVICE=$(echo $line | awk -F';' '{printf "%s", $4}' | tr -d '"')
IP=$(echo $line | awk -F';' '{printf "%s", $5}' | tr -d '"')
PORT=$(echo $line | awk -F';' '{printf "%s", $6}' | tr -d '"')

if [ "$SERVICE" == "Inbound" ]
then
if [ "$PORT" == "" ]
then
echo "El canal $PROC_NAME de $SERVICE no tiene PUERTO: IGNORA"
else
if nc -w $TIMEOUT -z $IP_ML_TRAIN $PORT; then
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_TRAIN y PUERTO: $PORT ------------> OK"
else
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_TRAIN y PUERTO: $PORT ------------> ERROR, Codigo ($?)."
fi
fi

fi

    done
            ;;
        "Comprobar acceso a ML PROD")
            echo "Comprobando acceso desde este equipo a los puertos de Millennium PROD"
    cat  $RUTA/lista_socket_FSI.csv | while read -r line
    do
SCP=$(echo $line | awk -F';' '{printf "%s", $1}' | tr -d '"')
ID=$(echo $line | awk -F';' '{printf "%s", $2}' | tr -d '"')
PROC_NAME=$(echo $line | awk -F';' '{printf "%s", $3}' | tr -d '"')
SERVICE=$(echo $line | awk -F';' '{printf "%s", $4}' | tr -d '"')
IP=$(echo $line | awk -F';' '{printf "%s", $5}' | tr -d '"')
PORT=$(echo $line | awk -F';' '{printf "%s", $6}' | tr -d '"')

if [ "$SERVICE" == "Inbound" ]
then
if [ "$PORT" == "" ]
then
echo "El canal $PROC_NAME de $SERVICE no tiene PUERTO: IGNORA"
else
if nc -w $TIMEOUT -z $IP_ML_PROD $PORT; then
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_PROD y PUERTO: $PORT ------------> OK"
else
echo "$SERVICE : $PROC_NAME con IP: $IP_ML_PROD y PUERTO: $PORT ------------> ERROR, Codigo ($?)."
fi
fi

fi

    done
            ;;
        "Comprobar acceso a sistemas externos")

            echo "Comprobando acceso desde este equipo a los puertos de Sistemas externos"
    cat  $RUTA/lista_socket_FSI.csv | while read -r line
    do
	SCP=$(echo $line | awk -F';' '{printf "%s", $1}' | tr -d '"')
	ID=$(echo $line | awk -F';' '{printf "%s", $2}' | tr -d '"')
	PROC_NAME=$(echo $line | awk -F';' '{printf "%s", $3}' | tr -d '"')
	SERVICE=$(echo $line | awk -F';' '{printf "%s", $4}' | tr -d '"')
	IP=$(echo $line | awk -F';' '{printf "%s", $5}' | tr -d '"')
	PORT=$(echo $line | awk -F';' '{printf "%s", $6}' | tr -d '"')

if [ "$SERVICE" == "Outbound" ]
then

if [ "$IP" == "" ]
then
echo "El canal $PROC_NAME de $SERVICE no tiene IP: IGNORA" 
else

if [ "$PORT" == "" ]
then
echo "El canal $PROC_NAME de $SERVICE no tiene PUERTO: IGNORA"
else
if nc -w $TIMEOUT -z $IP $PORT ; then
echo " $SERVICE : $PROC_NAME con IP: $IP y PUERTO: $PORT ------------> OK"
else
echo " $SERVICE : $PROC_NAME con IP: $IP y PUERTO: $PORT ------------> ERROR Codigo ($?)"
fi
fi
fi
fi
done;

            ;;
        "Salir")
            break
            ;;
        *) echo "Are you fucking kiding me? $REPLY";;
    esac
done
