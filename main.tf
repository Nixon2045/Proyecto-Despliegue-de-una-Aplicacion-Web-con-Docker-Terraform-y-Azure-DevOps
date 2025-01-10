terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
}

backend "azurerm" {
  resource_gruop_name   = "tf_backend_rg"
  storage_account_name  = "tfstateaccount"
  container_name        = "tfstate"
  key                   = "terraform.tfstate"
}

provider "azurerm" {
    features {}
}

resource "azurerm_group_name" "example for API" {
    name    =   "todo-api-rg"
    location=   "East US"
}

resource "azurerm_app_service_plan" "example for app service" {
    name                =   "todo-api-service-plan"
    location            =   "azurerm_group_name.example for api.location"
    resource_gruop_name =   "azurerm_resource_group.example for API.name"
    sku {
        tier = "Basic"
        size = "B1"
    }
}

resource "azurerm_app_service" "appservice" {
    name                =   "todo-api-service-plan"
    location            =   "azurerm_group_name.example for api.location"
    resource_gruop_name =   "azurerm_resource_group.example for API.name"
    app_service_plan_id =   "azurerm_app_service_plan.example for app service.id"

    site_config {
        always_on = true 
        linux_fx_version = "DOCKER|nox2045/todo-list-api"
    }
}