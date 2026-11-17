#!/bin/bash

echo "Ingrese el nombre del directorio:"
read directorio

if [ -d "$directorio" ]
then

    echo "El directorio existe"

    if [ -d backup ]
    then
        echo "La carpeta backup ya existe"
    else
        mkdir backup
    fi

    fecha=$(date +%Y-%m-%d_%H-%M-%S)

    archivo="backup/respaldo_$fecha.tar.gz"

    find "$directorio" -type f | wc -l > cantidad.txt

    cantidad=$(cat cantidad.txt)

    tar -czf "$archivo" -C "$directorio" .

    resultado=$?

    if [ $resultado -eq 0 ]
    then

        echo "Fecha: $fecha" >> backup.log
        echo "Archivos respaldados: $cantidad" >> backup.log
        echo "Tamaño del respaldo:" >> backup.log
        du -h "$archivo" >> backup.log
        echo "Estado: Exitoso" >> backup.log

        echo "Backup realizado correctamente"
        echo "Fecha: $fecha"
        echo "Archivos respaldados: $cantidad"
        du -h "$archivo"
        echo "Estado: Exitoso"

    else

        echo "Fecha: $fecha" >> backup.log
        echo "Estado: Error" >> backup.log

        echo "Error al realizar el backup"

    fi

else

    echo "El directorio no existe"

fi
