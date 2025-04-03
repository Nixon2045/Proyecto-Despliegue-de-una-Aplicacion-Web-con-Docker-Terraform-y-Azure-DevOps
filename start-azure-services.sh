#!/bin/bash
echo "Activando servicios de Azure para desarrollo..."

# Iniciar la Web App
echo "Iniciando Web App..."
az webapp start --name todo-api-app --resource-group todo-api-rg

# Aumentar a 1 instancia en los planes de App Service
echo "Configurando instancias de App Service Plans..."
az appservice plan update --name todo-api-app-plan --resource-group todo-api-rg --number-of-workers 1
az appservice plan update --name todo-api-service-plan --resource-group todo-api-rg --number-of-workers 1

echo "Servicios activados y listos para desarrollo."
