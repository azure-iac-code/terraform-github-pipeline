

provider "azurerm" {
  features {}
  use_msi = true
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