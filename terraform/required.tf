

terraform {
  required_providers {
    hashicorp = {
      source  = "hashicorp/hashicorp"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {

  features {}

  use_msi = true

}


backend "azurerm" {

  resource_group_name = "rg-runner"

  storage_account_name = "terraformdvbra"

  container_name = "tfstate"

  key = "key-github"

}



 