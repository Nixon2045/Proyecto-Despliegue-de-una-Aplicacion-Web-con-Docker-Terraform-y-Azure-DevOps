terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }


backend "azurerm" {
  resource_group_name   = "tf_backend_rg"
  storage_account_name  = "tfstateaccount1736995580"
  container_name        = "tfstate"
  key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
    features {}
    subscription_id =  "78ce0709-8050-4077-96ce-0ca5dd9bda30" 
}

resource "azurerm_resource_group" "exampleforAPI" {
    name    =   "todo-api-rg"
    location=   "westeurope"
}

resource "azurerm_service_plan" "exampleforappservice" {
    name                =   "todo-api-service-plan"
    location            =   azurerm_resource_group.exampleforAPI.location
    resource_group_name =   azurerm_resource_group.exampleforAPI.name
    sku_name            =   "B1"
    os_type             =   "Linux" 
}


resource "azurerm_linux_web_app" "appservice" {
    name                =   "todo-api-service-plan"
    location            =   azurerm_resource_group.exampleforAPI.location
    resource_group_name =   azurerm_resource_group.exampleforAPI.name
    service_plan_id     =   azurerm_service_plan.exampleforappservice.id

    app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"  = "false"
    "DOCKER_CUSTOM_IMAGE_NAME"             = "nox2045/todo-list-api"
    }

    site_config {
        always_on       = true 
    }
}
