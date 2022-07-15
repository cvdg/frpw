terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.14.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-web"
    storage_account_name = "griendeh24g4vw"
    container_name       = "tfstate"
    key                  = "htb.tfstate"
  }
}

provider "azurerm" {
  features {}
}
