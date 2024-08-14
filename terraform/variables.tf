variable "resource_group_name" {
  description = "Nome do Resource Group do Keyvault"
  type        = string
}

variable "virtual_network_name" {
  description = "Nome da VNET do Keyvault"
  type        = string
}

variable "azurerm_subnet_keyvault_name" {
  description = "Nome da SUBNET do Keyvault"
  type        = string
}

variable "azurerm_subnet_jump_name" {
  description = "Nome da SUBNET de Jump"
  type        = string
}

