# Sobre una ruta concreta, analizar si algun fichero 
# contiene menos de X lineas, si es así se enviará
# un email de alerta
# 07/08/2018

#!/bin/sh
mail=email@dominio.com
mensaje=/tmp/tmp.txt
ruta=   #ruta de ficheros a analizar
minimo=200 @ minimo de lineas para considerar alierta
alerta=0
echo "Inicio:" > $mensaje
 cd $ruta
 lista=`ls`
   for item in $lista
   do
        if [ ! -d $item ]
        then
            lineas=`wc -l $item | awk '{ print $1 }'`
            if [ $lineas -lt $minimo ]
                    then
                         alerta=1
                         echo -e "el fichero $item de $ruta tiene $lineas lineas \n" >>  $mensaje
            fi
        fi
    done

if [ $alerta -eq 1 ]
        then
                #echo "enviar a $mail" >> $mensaje
                mailx -s "[ALERTA] Hay ficheros con menos de $minimo lineas" $mail < $mensaje
fi

#DEBUG

if [ $alerta -eq 0 ]
        then
                echo "No hay ficheros en $ruta con menos de $minimo lineas" >> $mensaje
                mailx -s "[OK] No hay ficheros con menos de $minimo lineas" $mail <$mensaje
fi
