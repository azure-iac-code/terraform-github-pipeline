provider "azurerm" {
  features {}
  use_msi = true
}

terraform {
  backend "storage_account" {
    resource_group_name  = "rg-runner"
    storage_account_name = "terraformdvbra"
    container_name       = "tfstate"
    key                  = "key-github"
  }
}