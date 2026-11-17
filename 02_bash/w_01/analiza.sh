#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Se requiere al menos un argumento. Ejemplo de uso: ./analiza.sh <archivo1>..."
    exit 1
fi

for archivo in "$@"; do
    if [ ! -f "$archivo" ]; then
        echo "El archivo '$archivo' no existe."
        continue
    fi
    echo "Archivo: $archivo"
    echo "Lineas: $(wc -l < "$archivo")"
    echo "Palabras: $(wc -w < "$archivo")"
    echo "Caracteres: $(wc -c < "$archivo")"
    echo "Lineas con ERROR: $(grep -c "ERROR" "$archivo")"
    echo "Lineas con WARN: $(grep -c "WARN" "$archivo")"
done
