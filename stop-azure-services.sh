#!/bin/bash
echo "Deteniendo servicios de Azure para evitar cobros..."

# Detener la Web App
echo "Deteniendo Web App..."
az webapp stop --name todo-api-app --resource-group todo-api-rg

# Reducir a 0 instancias en los planes de App Service
echo "Reduciendo instancias de App Service Plans..."
az appservice plan update --name todo-api-app-plan --resource-group todo-api-rg --number-of-workers 0
az appservice plan update --name todo-api-service-plan --resource-group todo-api-rg --number-of-workers 0

# El ACR no se puede "detener", pero puedes cambiarlo a SKU Basic si está en otro nivel
echo "El ACR seguirá generando costos mínimos (no se puede detener)"

# La cuenta de almacenamiento tampoco se puede detener, pero suele ser de bajo costo
echo "La cuenta de almacenamiento seguirá generando costos mínimos"

echo "Servicios detenidos. Se han minimizado los costos."
