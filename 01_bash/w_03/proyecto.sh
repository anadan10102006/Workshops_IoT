#!/bin/bash

fecha=$(date +%Y-%m-%d)

carpeta="respaldo_$fecha"

mkdir "$carpeta"

contador=0
resultado=0

for archivo in *.txt
do
    if [ -f "$archivo" ]
    then
        cp "$archivo" "$carpeta/"
        resultado=$?

        if [ $resultado -eq 0 ]
        then
            contador=$((contador+1))
        fi
    fi
done

echo "Fecha: $fecha" > reporte.log
echo "Archivos copiados: $contador" >> reporte.log

if [ $resultado -eq 0 ] && [ $contador -gt 0 ]
then
    echo "Proceso finalizado. Archivos copiados: $contador"
    echo "Estado: Exitoso" >> reporte.log
else
    echo "No se copiaron archivos o ocurrió un error"
    echo "Estado: Error" >> reporte.log
fi

cat reporte.log
