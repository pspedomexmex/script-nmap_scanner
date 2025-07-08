#!/bin/bash

clear

figlet "ECM"
echo "TERMINAL REBELDE - Escaneo Nmap"


# Solicitar IP o dominio
read -p "🔍 Ingresa la IP o dominio a escanear: " OBJETIVO

# Validación mínima
if [ -z "$OBJETIVO" ]; then
  echo "❌ No ingresaste ninguna IP o dominio."
  exit 1
fi

echo
echo "🎯 Objetivo: $OBJETIVO"
echo "--------------------------------------------------------"
echo "1) Escaneo SIGILOSO (puertos comunes + servicios)"
echo "2) Escaneo SIGILOSO ULTRA (puertos 22, 80, 443, 3306 + servicios)"
echo "3) Escaneo RÁPIDO (ping + puertos frecuentes)"
echo "4) Escaneo AGRESIVO (SO, versiones, scripts NSE)"
echo "5) TODOS los puertos (1-65535, sigiloso + servicios)"
echo "6) Salir"
echo "--------------------------------------------------------"
read -p "👉 Elige una opción (1-6): " OPCION

case $OPCION in
  1)
    COMANDO="nmap -sS -sV -Pn -T2 --max-retries 1 --host-timeout 10s -p 22,80,443 $OBJETIVO"
    ;;
  2)
    COMANDO="nmap -sS -sV -Pn -T2 --max-retries 1 --host-timeout 10s -p 22,80,443,3306 $OBJETIVO"
    ;;
  3)
    COMANDO="nmap -F -T4 $OBJETIVO"
    ;;
  4)
    COMANDO="nmap -A -T4 $OBJETIVO"
    ;;
  5)
    COMANDO="nmap -sS -sV -Pn -p- -T2 --max-retries 1 --host-timeout 10s $OBJETIVO"
    ;;
  6)
    echo "👋 Saliendo..."
    exit 0
    ;;
  *)
    echo "❌ Opción inválida."
    exit 1
    ;;
esac

echo
echo "📌 Ejecutando:"
echo "$COMANDO"
echo
eval $COMANDO
