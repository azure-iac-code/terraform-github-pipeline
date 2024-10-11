data "azurerm_elastic_cloud_elasticsearch" "this" {
  count = var.ambiente == "pr" ? 1 : 0
  name                = var.elastic_search_name
  resource_group_name = var.elastic_search_resource_group
}

data "azurerm_private_dns_zone" "dns_zone" {
  name                = var.azurerm_private_dns_zone_name
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

data "azurerm_client_config" "current" {}

#----------------------------------------------------
# Data private dns zone queue
#----------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_queue" {
  count               = var.action_pvqueue == true ? 1 : 0
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

#---------------------------------------------------
# Data private dns zone file
#---------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_file" {
  count               = var.action_pvfile == true ? 1 : 0
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

#--------------------------------------------------
# Data private dns zone table
#--------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_table" {
  count               = var.action_pvtable == true ? 1 : 0
  name                = "privatelink.table.core.windows.net"
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

#-------------------------------------------------
# Data private dns zone dfs
#-------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_dfs" {
  count               = var.action_pvdfs == true ? 1 : 0
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

#-------------------------------------------------
# Data private dns zone blob
#-------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_blob" {
  count               = var.action_pvblob == true ? 1 : 0
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

#------------------------------------------------
# Data private dns zone web
#------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_web" {
  count               = var.action_pvweb == true ? 1 : 0
  name                = "privatelink.web.core.windows.net"
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
  provider            = azurerm.ditiidentity
}

#-----------------------------------------------
# Data vnet e subnet private endpoints
#-----------------------------------------------

data "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_virtual_network_name
  resource_group_name = var.azurerm_virtual_network_resource_group_name
  provider            = azurerm
}

data "azurerm_subnet" "subnet" {
  name                 = var.azurerm_subnet_name
  virtual_network_name = var.azurerm_virtual_network_name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  provider             = azurerm
}

#--------------------------------------------
# Data vnet e subnet do Jump
#--------------------------------------------

data "azurerm_virtual_network" "vnet_jump" {
  name                = var.azurerm_virtual_network_name_jump
  resource_group_name = var.azurerm_virtual_network_resource_group_name_jump
  provider            = azurerm.ditigerenciamento
}

data "azurerm_subnet" "subnet_jump" {
  name                 = var.azurerm_subnet_name_jump
  virtual_network_name = var.azurerm_virtual_network_name_jump
  resource_group_name  = data.azurerm_virtual_network.vnet_jump.resource_group_name
  provider             = azurerm.ditigerenciamento
}

#-------------------------------------
# Data key vault
#-------------------------------------

data "azurerm_key_vault" "vault" {
  name                = var.azurerm_key_vault_name
  resource_group_name = var.azurerm_key_vault_resource_group_name
  provider            = azurerm
}

data "azurerm_key_vault_key" "vault_key" {
  name         = var.azurerm_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.vault.id
  provider     = azurerm
}


data "azurerm_user_assigned_identity" "vault_identity" {
  name                = var.azurerm_user_assigned_identity_name
  resource_group_name = var.azurerm_user_assigned_identity_resource_group_name
  provider            = azurerm
}

#-------------------------------------
# Vinculo ao Backup Vault
#-------------------------------------

data "azurerm_data_protection_backup_vault" "backup_vault" {
  count               = var.azurerm_data_protection_backup_vault_action_bkpvault == true ? 1 : 0
  name                = var.azurerm_data_protection_backup_vault_name
  resource_group_name = var.azurerm_data_protection_backup_vault_resource_group_backup_vault
}