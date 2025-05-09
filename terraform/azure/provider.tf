terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.1.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  required_version = "~> 1.11.0"
}

provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
