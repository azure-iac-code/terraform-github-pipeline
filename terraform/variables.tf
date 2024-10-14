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
  default     = ["200.155.87.0/24", "104.93.21.0/24", "173.223.20.0/24", "2.23.186.0/24", "2.23.5.0/24", "23.205.103.0/24", "23.209.102.0/24", "23.213.55.0/24", "23.214.88.0/24", "23.218.93.0/24", "23.33.28.0/24", "23.38.109.0/24", "23.43.48.0/24", "23.43.49.0/24", "23.45.14.0/24", "23.47.58.0/24", "23.48.94.0/24", "23.64.120.0/24", "23.73.216.0/24", "92.122.182.0/24", "92.123.122.0/24", "23.48.168.0/22", "23.50.48.0/20", "67.220.142.19/30", "67.220.142.20/30", "67.220.142.21/30", "66.198.8.142/30", "66.198.8.144/30", "67.220.142.22/30", "66.198.8.141/30", "66.198.8.143/30"]
}

variable "azurerm_storage_account_type" {
  type        = string
  description = "Selecione a configuracao do storage account Ex DATALAKE"
  default     = "StorageV2"
}


variable "azurerm_virtual_network_name" {
  type        = string
  description = "Digite o nome da vnet existente."
  default     = "vnetdvditiautoacoeeastus"
}

variable "azurerm_subnet_name" {
  type        = string
  description = "Digite o nome da subnet existente."
  default     = "subkvdevbra001"
}

variable "azurerm_virtual_network_resource_group_name" {
  type        = string
  description = "Selecione o grupo de recurso existente."
  default     = "rgdvditiautovnetacoe"
}

variable "azurerm_storage_account_allow_nested_items_to_be_public" {
  type        = bool
  description = "Permitir ou proibir que itens aninhados nesta conta se tornem públicos."
  default     = false
}
#