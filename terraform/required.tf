provider "azurerm" {
  features {}
  use_msi = true
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-runner"
    storage_account_name = "tfstatemarcusbf"
    container_name       = "tfstate"
    key                  = "key-github"
  }
}
 