provider "azurerm" {
  features {}
  use_msi = true
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg_gh"
    storage_account_name = "githubactionmalaquias"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}
 