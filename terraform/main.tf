data "azurerm_resource_group" "rg_terraform" {
  name = "rg-terraform-modules"
}

data "azurerm_virtual_network" "vnet_terraform" {
  name                = var.azurerm_virtual_network_name
  resource_group_name = data.azurerm_resource_group_name
  #depends_on          = [data.azurerm_resource_group.this]
}

data "azurerm_subnet" "subnet_terraform" {
  name                 = "subnet-terraform-modules"
  resource_group_name  = data.azurerm_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_terraform.name
  #depends_on           = [data.azurerm_resource_group.this]
}

resource "azurerm_subnet" "subnet_terraform_2" {
  name                 = var.azurerm_subnet
  address_prefixes     = var.azurerm_subnet_address_prefixes
  resource_group_name  = data.azurerm_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_terraform.name
}

