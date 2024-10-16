variable "network_rules_action" {
  type        = string
  description = "Escolha o nivel de acesso de rede allow ou deny"
  default     = "Deny"
}

variable "ambiente" {
  type        = string
  description = "Ambiente"
  default     = "dv"
}

variable "network_rules_CIDRproxy" {
  type        = list(string)
  description = "IP e Mascara do proxy servico CIDR"
  default     = ["200.170.94.0/24", "53.99.57.0/24"]
}

variable "azurerm_storage_account_type" {
  type        = string
  description = "Selecione a configuracao do storage account Ex DATALAKE"
  default     = "StorageV2"
}


variable "azurerm_virtual_network_name" {
  type        = string
  description = "Digite o nome da vnet existente."
  default     = "vnetdveastus"
}

variable "azurerm_subnet_name" {
  type        = string
  description = "Digite o nome da subnet existente."
  default     = "subkvdevteste001"
}

variable "azurerm_virtual_network_resource_group_name" {
  type        = string
  description = "Selecione o grupo de recurso existente."
  default     = "rgdvvnetteste"
}

variable "azurerm_storage_account_allow_nested_items_to_be_public" {
  type        = bool
  description = "Permitir ou proibir que itens aninhados nesta conta se tornem públicos."
  default     = false
}
