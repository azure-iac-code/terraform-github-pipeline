variable "azurerm_virtual_network_name" {
  description = "VNET name for Terraform resources"
  type        = string
}

variable "azurerm_subnet" {
  description = "Subnet name for Terraform resources"
  type        = string
}

variable "azurerm_subnet_address_prefixes" {
  description = "Address prefixes for subnet-terraform-modules-2"
  type        = list(string)
}

