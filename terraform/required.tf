terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# provider "azurerm" {
#   features {}
#   use_msi = true
# }

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-runner"
    storage_account_name = "terraformdvbra"
    container_name       = "tfstate"
    key                  = "key-github"
  }
}