terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  use_msi = true
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "eastus"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-runner"
    storage_account_name = "terraformdvbra"
    container_name       = "tfstate"
    key                  = "key-github"
  }
}


# resource "azurerm_resource_group" "rg" {
# name = "myTFResourceGroup"
# location = "eastus"
# }