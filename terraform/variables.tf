

# variable "azurerm_virtual_network_name" {
#   description = "Informar o nome da vnet para busca do ID da subnet"
#   type        = string
# }

# variable "subnet_resource_group_name" {
#   description = "Informar o nome do grupo de recursos para busca do ID da subnet"
#   type        = string
# }

# variable "azurerm_private_dns_zone_resource_group_name" {
#   description = "Nome do grupo de recurso existente da zona de DNS"
#   type        = string
#   default     = "pvtzones-rg"
# }

# variable "purge_protection_enabled" {
#   description = "Proteção contra exclusão deste componente"
#   type        = bool
#   default     = true
# }

# variable "azurerm_subnet_keyvault_name" {
#   description = "Informar o nome da subnet para busca do ID"
#   type        = string
#   default     = "snetdvditiautodvptendpoint001"
# }

# variable "azurerm_resource_group_location" {
#   description = "Região do resource group"
#   type        = string
# }

# variable "azurerm_virtual_network" {
#   description = "Insira o nome da VNET de gerenciamento (onde se encontra o jump)"
#   type        = string
#   default     = "GERENCIAMENTO-VNET"
# }

# variable "azurerm_subnet_jump_name" {
#   description = "Insira o nome da subnet de gerenciamento (onde se encontra o jump)"
#   type        = string
#   default     = "jump-subnet"
# }

# variable "azurerm_resource_group_name" {
#   description = "Insira o nome do grupo de recurso da VNET de gerenciamento"
#   type        = string
#   default     = "GERENCIAMENTO-VNET-RG"
# }

# variable "azurerm_private_dns_zone_name" {
#   description = "Insira o nome da zone DNS privada que o recurso irá utillizar"
#   type        = string
#   default     = "privatelink.vaultcore.azure.net"
# }

# variable "public_network_access_enabled" {
#   description = "Permitir ou não o acesso da rede pública a este componente"
#   type        = bool
#   default     = true
# }


# variable "ambiente" {
#   description = "Usado para compor o nome do recurso."
#   type        = string
#   default     = "dv"
# }

# #---------------------------------------------------------------
# # Dados Log Analitics
# #---------------------------------------------------------------

#---------------------------------------------------------------
#                            KEYVAULT
#---------------------------------------------------------------
variable "azurerm_key_vault_name" {
  description = "Nome que será usado para o Key Vault"
  type        = string
  default     = "kvazudvbraditiauto500"
}

variable "azurerm_key_vault_location" {
  description = "Localização e região para o componnte"
  type        = string
  default     = "eastus"
}

variable "sku_name" {
  description = "Opções de SKU do componente (standard ou premium)"
  type        = string
  default     = "premium"
}

variable "enabled_for_deployment" {
  description = "Habilitar a permissão de recuperar certificados armazenados como segredos do Key Vault, para as máquinas virtuais da Azure"
  type        = bool
  default     = true
}

variable "enabled_for_disk_encryption" {
  description = "Habilitar ou não o Azure disk encryption"
  type        = bool
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "Habilitar a permissão de recuperar segredos do Key Vault, para o Azure resource manager"
  type        = bool
  default     = true
}

variable "enable_rbac_authorization" {
  description = "Habilitar o Key Vault a usar o controle de acesso baseado em função (RBAC) para autorização de ações de dados"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Quantidade de dias que os itens ficam retidos após a exclusão"
  type        = number
  default     = "90"
}

variable "purge_protection_enabled" {
  description = "Proteção contra exclusão deste componente"
  type        = bool
  default     = true
}

variable "network_acls_bypass" {
  description = "Especifica qual tráfego pode ignorar as regras de rede (AzureServices ou None)"
  type        = string
  default     = "AzureServices"
}

variable "network_acls_default_action" {
  description = "Ação padrão quando demais tráfegos (Default: Deny)"
  type        = string
  default     = "Deny"
}

variable "network_acls_ip_rules" {
  description = "Autorização de ip no firewall do kv"
  type        = list(string)
  default     = ["200.155.87.0/24"]
}

variable "azurerm_key_vault_resource_group_name" { #azurerm_key_vault_resource_group_name
  description = "Nome do grupo de recurso existente para o componente do Key Vault"
  type        = string
  default     = "rg-keyvault"
}

variable "private_service_connection_is_manual_connection" {
  description = "Requer aprovação manual do Recurso remoto"
  type        = bool
  default     = false
}

variable "azurerm_monitor_diagnostic_setting_name" {
  description = "Nome que será usado para o Key Vault"
  type        = string
  default     = "azmonitordvkv001"
}

variable "eventhub_name" {
  description = "Nome do Event Hub"
  type        = string
  default     = "ehbrmgmtsiemqradar"
}

variable "azurerm_eventhub_namespace_authorization_rule_name" {
  description = "Nome da regra de autorização do Event Hub"
  type        = string
  default     = "RootManageSharedAccessKey"
}

variable "azurerm_eventhub_namespace_authorization_rule_resource_group_name" {
  description = "Nome do Grupo de Recurso onde se encontra o Event Hub"
  type        = string
  default     = "rg-siem-qradar"
}

variable "namespace_name" {
  description = "Nome do namespace do Event Hub"
  type        = string
  default     = "eventhubmgmtsiemqradar"
}

variable "azurerm_eventhub_resource_group_name" {
  description = "Nome do Resource Group do Event Hub"
  type        = string
  default     = "rgazdvauditieventhub"
}






variable "ambiente" {
  description = "Ambiente"
  type        = string
  default     = "dv"
}