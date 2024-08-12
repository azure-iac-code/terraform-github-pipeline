# variable "virtual_network_name" {
#   description = "Nome da Virtual Network"
#   type        = string
# }

# variable "virtual_network_resource_group_name" {
#   description = "Nome do Resource Group da Virtual Network"
#   type        = string
# }

variable "keyvault_subnet_name" {
  description = "Nome da Subnet para provisionamento"
  type        = string
}

variable "azurerm_key_vault_name" {
  description = "Nome do KeyVault Contendo a chave de criptografia"
  type        = string
}

variable "subnet_resource_group_name" {
  description = "Nome do Resource Group do KeyVault Contendo a chave de criptografia"
  type        = string
}

variable "sku_name" {
  description = "Opções de SKU do componente (standard ou premium)"
  type        = string
}

variable "enabled_for_deployment" {
  description = "Habilitar a permissão de recuperar certificados armazenados como segredos do Key Vault, para as máquinas virtuais da Azure"
  type        = bool
}

variable "enabled_for_disk_encryption" {
  description = "Habilitar ou não o Azure disk encryption"
  type        = bool
}

variable "enabled_for_template_deployment" {
  description = "Habilitar a permissão de recuperar segredos do Key Vault, para o Azure resource manager"
  type        = bool
}

variable "enable_rbac_authorization" {
  description = "Habilitar o Key Vault a usar o controle de acesso baseado em função (RBAC) para autorização de ações de dados"
  type        = bool
}

variable "soft_delete_retention_days" {
  description = "Quantidade de dias que os itens ficam retidos após a exclusão"
  type        = number
}

variable "purge_protection_enabled" {
  description = "Proteção contra exclusão deste componente"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Permitir ou não o acesso da rede pública a este componente"
  type        = bool
}

variable "azurerm_key_vault_resource_group_name" {
  description = "Nome do Resource Group do Keyvault"
  type        = string
}

variable "subnet_virtual_network_name" {
  description = "Nome da Virtual Network"
  type        = string
}

variable "azurerm_private_endpoint_name" {
  description = "Nome que será usado para o Key Vault"
  type        = string
}

variable "private_service_connection_name" {
  description = "Nome da Private Service Connection"
  type        = string
}

variable "azurerm_monitor_diagnostic_setting_name" {
  description = "Nome que será usado para o Key Vault"
  type        = string
}

variable "azurerm_private_dns_zone_name" {
  description = "Insira o nome da zone DNS privada que o recurso irá utillizar"
  type        = string
}

variable "azurerm_eventhub_namespace_authorization_rule_name" {
  description = "Nome da regra de autorização do Event Hub"
  type        = string
}

variable "azurerm_eventhub_namespace_authorization_rule_resource_group_name" {
  description = "Nome do Grupo de Recurso onde se encontra o Event Hub"
  type        = string
}

variable "namespace_name" {
  description = "Nome do namespace do Event Hub"
  type        = string
}

variable "eventhub_name" {
  description = "Nome do Event Hub"
  type        = string
}

###################################################################################
#  VNET
###################################################################################
variable "azurerm_virtual_network_location" {
  type        = string
  description = "Azurerm virtual network location"
}

variable "azurerm_virtual_network_address_space" {
  type        = list(string)
  description = "Azurerm virtual network Address space"
}

variable "azurerm_subnet_address_prefixes" {
  type        = list(string)
  description = "Azurerm virtual network address prefixes"
}



###################################################################################
#  RESOURCE GROUP
###################################################################################
variable "azurerm_resource_group_location" {
  type        = string
  description = "Localizacao do resource group"
}

variable "azurerm_subnet_name" {
  description = "Nome da Subnet para provisionamento"
  type        = string
}

variable "jump_subnet_name" {
  description = "Insira o nome da subnet de gerenciamento (onde se encontra o jump)"
  type        = string
}