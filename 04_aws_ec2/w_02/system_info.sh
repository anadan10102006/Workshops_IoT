#!/bin/bash

echo "Hostname: $(hostname)"
echo "Usuario: $(whoami)"
echo "Fecha: $(date)"
echo "Uptime:"
uptime

echo "Disco:"
df -h "$1"

echo "Memoria:"
free -h
