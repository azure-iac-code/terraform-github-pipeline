data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "this" {
  name                = var.azurerm_virtual_network_name
  resource_group_name = var.azurerm_virtual_network_resource_group_name
  provider            = azurerm
}

data "azurerm_subnet" "subnet" {
  name                 = var.azurerm_subnet_name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = var.azurerm_virtual_network_resource_group_name
  provider             = azurerm
}
############