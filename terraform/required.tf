terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_msi = true
}

terraform {
  backend "azurerm" {
    subscription_id = "f0c1e47b-a8bc-4071-9771-e81efd9b2cf1"
    resource_group_name  = "rg-runner"
    storage_account_name = "terraformdvbra"
    container_name       = "tfstate"
    key                  = "key-github"
  }
}