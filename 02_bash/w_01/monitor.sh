#!/bin/bash

umbral=75

echo "===== MONITOR DEL CONTENEDOR ====="
echo "Hostname: $(hostname)"
echo "Usuario: $(whoami)"
echo "Fecha: $(date)"
echo "Directorio: $(pwd)"

echo "===== DISCO ====="
df -h

echo "===== PROCESOS ====="
ps aux | wc -l

uso=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if (( uso >= umbral )); then
    echo "El uso del disco ($uso%) supera el umbral permitido ($umbral%)."
else
    echo "Uso de disco dentro del límite normal ($uso%)."
fi

echo "===== FIN DEL REPORTE ====="
echo "El diagnostico ha terminado exitosamente"
