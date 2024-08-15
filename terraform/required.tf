
terraform {

  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"

      version = ">= 2.0.0"

    }

  }

  backend "azurerm" {

    resource_group_name = "rg-runner"

    storage_account_name = "terraformdvbra"

    container_name = "tfstate"

    key = "key-github"

  }

}

provider "azurerm" {

  features {}

  use_msi = true

}

 