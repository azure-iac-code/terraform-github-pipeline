#-----------------------------------------------------------------------------------------------------------------------
# Variáveis da conta de armazenamento
#-----------------------------------------------------------------------------------------------------------------------

variable "azurerm_private_dns_zone_name" {
  description = "Insira o nome da zone DNS privada que o recurso irá utillizar"
  type        = string
  default     = "privatelink.vaultcore.azure.net"
}

variable "azurerm_storage_account_resource_group_name" {
  type        = string
  description = "Escolha o nome do grupo de recurso existente."
}

variable "azurerm_virtual_network_name" {
  type        = string
  description = "Digite o nome da vnet existente."
}

variable "azurerm_subnet_name" {
  type        = string
  description = "Digite o nome da subnet existente."
}

variable "azurerm_virtual_network_resource_group_name" {
  type        = string
  description = "Selecione o grupo de recurso existente."
}

variable "azurerm_virtual_network_name_jump" {
  type        = string
  description = "Nome da vnet do jumpserver"
  default     = "GERENCIAMENTO-VNET"
}

variable "azurerm_subnet_name_jump" {
  type        = string
  description = "Nome da subnet do jumpserver"
  default     = "jumper-subnet"
}

variable "sas_policy_expiration_period" {
  type        = string
  description = "Tempo de expiração da política SAS"
  default     = "1.00:00:00"
}

variable "azurerm_virtual_network_resource_group_name_jump" {
  type        = string
  description = "Grupo de recurso da vnet do jumpserver"
  default     = "GERENCIAMENTO-VNET-RG"
}

variable "azurerm_storage_account_name" {
  type        = string
  description = "Digite o nome da conta de armazenamento."
}

variable "location" {
  type        = string
  description = "Selecione a região."
  default     = "brazilsouth"
}

variable "azurerm_storage_account_tier" {
  type        = string
  description = "Selecione o tipo de conta de armazenamento."
  default     = "Standard"
}

variable "azurerm_storage_account_access_tier" {
  type        = string
  description = "Selecione o nivel de acesso."
  default     = "Hot"
}

variable "azurerm_storage_account_account_kind" {
  type        = string
  description = "Selecione o tipo da conta default é StorageV2"
  default     = "StorageV2"
}

variable "azurerm_storage_account_replication" {
  type        = string
  description = "Selecione o tipo de replicação."
  default     = "GRS"
}


variable "azurerm_storage_account_infrastructure_encryption_enabled" {
  type        = bool
  description = "Habilita a criptografia de infraestrutura."
  default     = true
}

variable "azurerm_storage_account_public_network_access_enabled" {
  type        = bool
  description = "Habilita o acesso à rede pública."
  default     = true
}

variable "azurerm_storage_account_allow_nested_items_to_be_public" {
  type        = bool
  description = "Permitir ou proibir que itens aninhados nesta conta se tornem públicos."
  default     = false
}

variable "azurerm_storage_account_recovery_in_time" {
  type        = bool
  description = "Habilita o recovery in time do blob."
  default     = false
}

variable "azurerm_storage_account_soft_delete_blob" {
  type        = bool
  description = "Habilita o soft delete do blob."
  default     = false
}

variable "azurerm_storage_account_soft_delete_containers" {
  type        = bool
  description = "Habilita o soft delete do container do blob."
  default     = false
}

variable "azurerm_storage_account_is_hns_enabled" {
  type        = bool
  description = "O namespace hierárquico está habilitado? Isso pode ser usado com o Azure Data Lake."
  default     = false
}
variable "azurerm_storage_account_shared_access_key_enabled" {
  type    = bool
  default = true
}
variable "azurerm_storage_account_local_user_enabled" {
  type    = bool
  default = false
}

variable "azurerm_storage_account_static_website_enabled" {
  type        = bool
  description = "Habilita o uso de um site estático."
  default     = false
}

variable "azurerm_storage_account_static_website" {
  type = list(object({
    index_document     = optional(string)
    error_404_document = optional(string)
  }))
  default = [{
    error_404_document = "error.html"
    index_document     = "index.html"
  }]
  description = "Mapa contendo os valores index e error http."
}

variable "azurerm_storage_account_blob_properties" {
  type = list(object({
    delete_retention_days           = optional(string)
    restore_days                    = optional(string)
    container_delete_retention_days = optional(string)
    change_feed_retention_in_days   = optional(string)
  }))
  default = [{
    delete_retention_days           = 7
    restore_days                    = 7
    container_delete_retention_days = 7
    change_feed_retention_in_days   = null
  }]
  description = "Mapa contendo os valores para dataprotection blob"
}

######## Tipo de Configuração para Storage Account #########
variable "azurerm_storage_account_type" {
  type        = string
  description = "Selecione a configuracao do storage account Ex DATALAKE"
  default     = "StorageV2"
}

######## Variáveis da vinculo recovery service #########
variable "azurerm_backup_container_storage_account_recovery_vault_name" {
  type        = string
  description = "Digite o nome do recovery service vault."
  default     = "naoaplica"
}

variable "azurerm_backup_container_storage_account_resource_group_recovery_vault" {
  type        = string
  description = "Selecione o grupo de recurso existente."
  default     = "naoaplica"
}

variable "azurerm_backup_container_storage_account_action_bkpcontainer" {
  type        = bool
  description = "Cria vinculo do recovery service vault"
  default     = false
}

####### Variáveis da vinculo backup vault #########

variable "azurerm_data_protection_backup_vault_name" {
  type        = string
  description = "Digite o nome do backup vault."
  default     = "naoaplica"
}

variable "azurerm_data_protection_backup_vault_resource_group_backup_vault" {
  type        = string
  description = "Selecione o grupo de recurso do backup vault."
  default     = "naoaplica"
}

variable "azurerm_data_protection_backup_instance_blob_storage_bkp_policy_name" {
  type        = string
  description = "Nome do backup policy"
  default     = "naoaplica"
}

variable "azurerm_data_protection_backup_vault_action_bkpvault" {
  type        = bool
  description = "Cria vinculo do backup vault"
  default     = false
}

######### Variáveis do private endpoint #########

variable "network_rules_action" {
  type        = string
  description = "Escolha o nivel de acesso de rede allow ou deny"
  default     = "Deny"
}

variable "network_rules_CIDRproxy" {
  type        = list(string)
  description = "IP e Mascara do proxy servico CIDR"
  default     = ["200.155.87.0/24", "104.93.21.0/24", "173.223.20.0/24", "2.23.186.0/24", "2.23.5.0/24", "23.205.103.0/24", "23.209.102.0/24", "23.213.55.0/24", "23.214.88.0/24", "23.218.93.0/24", "23.33.28.0/24", "23.38.109.0/24", "23.43.48.0/24", "23.43.49.0/24", "23.45.14.0/24", "23.47.58.0/24", "23.48.94.0/24", "23.64.120.0/24", "23.73.216.0/24", "92.122.182.0/24", "92.123.122.0/24", "23.48.168.0/22", "23.50.48.0/20", "67.220.142.19/30", "67.220.142.20/30", "67.220.142.21/30", "66.198.8.142/30", "66.198.8.144/30", "67.220.142.22/30", "66.198.8.141/30", "66.198.8.143/30"]
}

variable "action_pvqueue" {
  type        = bool
  description = "Cria endpoint queue"
  default     = true
}

variable "action_pvfile" {
  type        = bool
  description = "Cria endpoint file"
  default     = false
}

variable "action_pvtable" {
  type        = bool
  description = "Cria endpoint table"
  default     = true
}

variable "action_pvdfs" {
  type        = bool
  description = "Cria endpoint dfs"
  default     = false
}

variable "action_pvblob" {
  type        = bool
  description = "Cria endpoint blob"
  default     = true
}

variable "action_pvweb" {
  type        = bool
  description = "Cria endpoint web"
  default     = true
}

############ Variáveis do vault e identity ##############

variable "azurerm_key_vault_name" {
  type        = string
  description = "Nome do key vault."
}

variable "azurerm_key_vault_key_name" {
  type        = string
  description = "Chave do key vault."
}

variable "azurerm_user_assigned_identity_name" {
  type        = string
  description = "Identidade do key vault."
}

variable "azurerm_user_assigned_identity_resource_group_name" {
  type        = string
  description = "Grupo de recurso da Identidade do key vault"
}

variable "azurerm_key_vault_resource_group_name" {
  type        = string
  description = "Selecione o grupo de recurso existente."
}

variable "azurerm_private_dns_zone_resource_group_name" {
  type        = string
  description = "Escolha o grupo de recurso do dns."
  default     = "pvtzones-rg"
}

variable "azurerm_storage_encryption_scope_action_encryption" {
  type        = bool
  description = "Cria um escopo de criptografia"
  default     = false
}

#------------------------
# Variáveis de tags (map)
#------------------------

variable "tagcdn" {
  type        = map(any)
  description = "Recebe os valor do akamai."
}
variable "tags" {
  type        = map(any)
  description = "Recebe os valores de FinOps."
}
variable "ambiente" {
  description = "Selecione o ambiente para o deploy do recurso."
  type        = string
}

variable "elastic_search_name" {
  type        = string
  description = "Nome do Elastic Search"
  default = null
}

variable "elastic_search_resource_group" {
  type        = string
  description = "Grupo de Recurso do Elastic Search"
  default = null
}