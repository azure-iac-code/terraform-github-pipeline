locals {
  network_subnets = var.azurerm_storage_account_type == "DATALAKE" ? tolist([data.azurerm_subnet.subnet.id, data.azurerm_subnet.subnet_jump.id]) : tolist([data.azurerm_subnet.subnet.id, data.azurerm_subnet.subnet_jump.id])
}

#--------------------------------------------------------
# Rercuso role permissão Backup vault
#--------------------------------------------------------

resource "azurerm_role_assignment" "role_backup_vault" {
  count                = var.azurerm_data_protection_backup_vault_action_bkpvault == true ? 1 : 0
  scope                = azurerm_storage_account.st.id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = data.azurerm_data_protection_backup_vault.backup_vault[0].identity[0].principal_id
}

#---------------------------------------------------------
# Rercuso protenção para Backup vault
#---------------------------------------------------------

resource "azurerm_data_protection_backup_instance_blob_storage" "st_backup_vault" {
  count              = var.azurerm_data_protection_backup_vault_action_bkpvault == true ? 1 : 0
  name               = "BackupInstance${azurerm_storage_account.st.name}"
  vault_id           = data.azurerm_data_protection_backup_vault.backup_vault[0].id
  location           = var.location
  storage_account_id = azurerm_storage_account.st.id
  backup_policy_id   = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_data_protection_backup_vault.backup_vault[0].resource_group_name}/providers/Microsoft.DataProtection/backupVaults/${data.azurerm_data_protection_backup_vault.backup_vault[0].name}/backupPolicies/${var.azurerm_data_protection_backup_instance_blob_storage_bkp_policy_name}"
  depends_on         = [azurerm_role_assignment.role_backup_vault]
}

#-------------------------------------------------------
# Vinculo ao Recovery Service Vault File VM
#-------------------------------------------------------

resource "azurerm_backup_container_storage_account" "backup_container" {
  count               = var.azurerm_backup_container_storage_account_action_bkpcontainer == true ? 1 : 0
  resource_group_name = var.azurerm_backup_container_storage_account_resource_group_recovery_vault
  recovery_vault_name = var.azurerm_backup_container_storage_account_recovery_vault_name
  storage_account_id  = azurerm_storage_account.st.id
}

#-------------------------------------------------------
# Criação do recurso conta de armazenamento
#-------------------------------------------------------

resource "azurerm_storage_account" "st" {
  name                              = "stazu${var.ambiente}bra${var.azurerm_storage_account_name}"
  resource_group_name               = var.azurerm_storage_account_resource_group_name
  location                          = var.location
  account_tier                      = var.azurerm_storage_account_tier
  account_replication_type          = var.azurerm_storage_account_replication
  access_tier                       = var.azurerm_storage_account_access_tier
  account_kind                      = var.azurerm_storage_account_account_kind
  queue_encryption_key_type         = var.azurerm_storage_account_account_kind == "StorageV2" ? "Account" : "Service"
  table_encryption_key_type         = var.azurerm_storage_account_account_kind == "StorageV2" ? "Account" : "Service"
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = var.azurerm_storage_account_public_network_access_enabled
  allow_nested_items_to_be_public   = var.azurerm_storage_account_allow_nested_items_to_be_public
  is_hns_enabled                    = var.azurerm_storage_account_is_hns_enabled
  shared_access_key_enabled         = var.azurerm_storage_account_shared_access_key_enabled
  local_user_enabled                = var.azurerm_storage_account_local_user_enabled       
  tags                              = var.azurerm_storage_account_static_website_enabled == true ? (var.ambiente == "dv" ? merge(var.tags) : merge(var.tags, var.tagcdn)) : merge(var.tags)
  provider                          = azurerm

  sas_policy {
    expiration_period = var.sas_policy_expiration_period
  }

  dynamic "blob_properties" {
    for_each = toset(var.azurerm_storage_account_blob_properties)
    content {
      versioning_enabled            = var.azurerm_storage_account_recovery_in_time == true ? true : false
      change_feed_enabled           = var.azurerm_storage_account_recovery_in_time == true ? true : false
      change_feed_retention_in_days = var.azurerm_storage_account_recovery_in_time == true ? blob_properties.value.change_feed_retention_in_days : null

      dynamic "container_delete_retention_policy" {
        for_each = var.azurerm_storage_account_soft_delete_containers == true ? toset(var.azurerm_storage_account_blob_properties) : toset([])
        content {
          days = blob_properties.value.container_delete_retention_days
        }
      }
      dynamic "delete_retention_policy" {
        for_each = var.azurerm_storage_account_soft_delete_blob || var.azurerm_storage_account_recovery_in_time == true ? toset(var.azurerm_storage_account_blob_properties) : toset([])
        content {
          days = blob_properties.value.delete_retention_days
        }
      }
      dynamic "restore_policy" {
        for_each = var.azurerm_storage_account_recovery_in_time == true ? toset(var.azurerm_storage_account_blob_properties) : toset([])
        content {
          days = blob_properties.value.restore_days
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      infrastructure_encryption_enabled,
    ]
  }

  customer_managed_key {
    key_vault_key_id          = data.azurerm_key_vault_key.vault_key.id
    user_assigned_identity_id = data.azurerm_user_assigned_identity.vault_identity.id
  }

  identity {
    identity_ids = [
      data.azurerm_user_assigned_identity.vault_identity.id,
    ]
    type = "UserAssigned"
  }

  network_rules {
    default_action             = var.network_rules_action
    virtual_network_subnet_ids = local.network_subnets
    ip_rules                   = var.ambiente == "dv" ? ["200.155.87.0/24"] : var.network_rules_CIDRproxy
    bypass                     = ["Metrics", "AzureServices", "Logging"]
  }

  #web_static
  dynamic "static_website" {
    for_each = var.azurerm_storage_account_static_website_enabled == false ? toset([]) : toset(var.azurerm_storage_account_static_website)
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

}

resource "azurerm_private_endpoint" "privateendpointqueue" {
  count               = var.action_pvqueue == true ? 1 : 0
  name                = "pvtstazu${var.ambiente}bra${var.azurerm_storage_account_name}queue"
  resource_group_name = var.azurerm_storage_account_resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = var.tags
  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_storage_account_name}queue"
    private_connection_resource_id = azurerm_storage_account.st.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.dns_zone_queue[0].name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone_queue[0].id]
  }
}

#---------------------------------------------------
# Criação do recurso privateendpoint file
#---------------------------------------------------

resource "azurerm_private_endpoint" "privateendpointfile" {
  count               = var.action_pvfile == true ? 1 : 0
  name                = "pvtstazu${var.ambiente}bra${var.azurerm_storage_account_name}file"
  resource_group_name = var.azurerm_storage_account_resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = var.tags
  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_storage_account_name}file"
    private_connection_resource_id = azurerm_storage_account.st.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.dns_zone_file[0].name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone_file[0].id]
  }
}

#----------------------------------------------------------
# Criação do recurso privateendpoint table
#----------------------------------------------------------

resource "azurerm_private_endpoint" "privateendpointtable" {
  count               = var.action_pvtable == true ? 1 : 0
  name                = "pvtstazu${var.ambiente}bra${var.azurerm_storage_account_name}table"
  resource_group_name = var.azurerm_storage_account_resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = var.tags
  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_storage_account_name}table"
    private_connection_resource_id = azurerm_storage_account.st.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.dns_zone_table[0].name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone_table[0].id]
  }
}

#----------------------------------------------------------
# Criação do recurso privateendpoint dfs
#----------------------------------------------------------

resource "azurerm_private_endpoint" "privateendpointdfs" {
  count               = var.action_pvdfs == true ? 1 : 0
  name                = "pvtstazu${var.ambiente}bra${var.azurerm_storage_account_name}dfs"
  resource_group_name = var.azurerm_storage_account_resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = var.tags
  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_storage_account_name}dfs"
    private_connection_resource_id = azurerm_storage_account.st.id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.dns_zone_dfs[0].name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone_dfs[0].id]
  }
}

#----------------------------------------------------------------
# Criação do recurso privateendpoint blob
#----------------------------------------------------------------

resource "azurerm_private_endpoint" "privateendpointblob" {
  count               = var.action_pvblob == true ? 1 : 0
  name                = "pvtstazu${var.ambiente}bra${var.azurerm_storage_account_name}blob"
  resource_group_name = var.azurerm_storage_account_resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = var.tags
  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_storage_account_name}blob"
    private_connection_resource_id = azurerm_storage_account.st.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.dns_zone_blob[0].name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone_blob[0].id]
  }
}

#---------------------------------------------------------------
# Criação do recurso privateendpoint web
#---------------------------------------------------------------

resource "azurerm_private_endpoint" "privateendpointweb" {
  count               = var.action_pvweb == true ? 1 : 0
  name                = "pvtstazu${var.ambiente}bra${var.azurerm_storage_account_name}web"
  resource_group_name = var.azurerm_storage_account_resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = var.tags
  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_storage_account_name}web"
    private_connection_resource_id = azurerm_storage_account.st.id
    is_manual_connection           = false
    subresource_names              = ["web"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.dns_zone_web[0].name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone_web[0].id]
  }
}

#------------------------------------------------------------------
# Criação do recurso encryption
#------------------------------------------------------------------

resource "azurerm_storage_encryption_scope" "encryption" {
  count                              = var.azurerm_storage_encryption_scope_action_encryption == true ? 1 : 0
  name                               = "microsoftkeyvaultmanage"
  storage_account_id                 = azurerm_storage_account.st.id
  source                             = "Microsoft.KeyVault"
  key_vault_key_id                   = data.azurerm_key_vault_key.vault_key.id
  infrastructure_encryption_required = azurerm_storage_account.st.infrastructure_encryption_enabled
  provider                           = azurerm
}


#---------------------------------------------------
# Atribuição de role Contributor
#---------------------------------------------------

resource "azurerm_role_assignment" "container" {
  scope                = azurerm_storage_account.st.id
  role_definition_name = "Azure Container Storage Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "blob" {
  scope                = azurerm_storage_account.st.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "queue" {
  scope                = azurerm_storage_account.st.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

# resource "azurerm_role_assignment" "queue_reader" {
#   scope                = azurerm_storage_account.st.id
#   role_definition_name = "Reader"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

resource "azurerm_role_assignment" "table" {
  scope                = azurerm_storage_account.st.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}


//Ativa diagnostic settings quando em produção
resource "azurerm_monitor_diagnostic_setting" "blob_diag" {
  count = var.ambiente == "pr" ? 1 : 0
  name                           = "blob${var.ambiente}bra${var.azurerm_storage_account_name}_diagnostic"
  target_resource_id             = "${azurerm_storage_account.st.id}/blobServices/default/"
  partner_solution_id            = data.azurerm_elastic_cloud_elasticsearch.this[0].id
  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_log {
    category = "StorageWrite"
  }

  depends_on = [ data.azurerm_elastic_cloud_elasticsearch.this ]
}

 //'blobServices', 'fileServices', 'queueServices', or 'tableServices')
//Ativa diagnostic settings quando em produção
resource "azurerm_monitor_diagnostic_setting" "file_diag" {
  count = var.ambiente == "pr" ? 1 : 0
  name                           = "file${var.ambiente}bra${var.azurerm_storage_account_name}_diagnostic"
  target_resource_id             = "${azurerm_storage_account.st.id}/fileServices/default/"
  partner_solution_id            = data.azurerm_elastic_cloud_elasticsearch.this[0].id
  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_log {
    category = "StorageWrite"
  }

  depends_on = [ data.azurerm_elastic_cloud_elasticsearch.this ]
}

resource "azurerm_monitor_diagnostic_setting" "queue_diag" {
  count = var.ambiente == "pr" ? 1 : 0
  name                           = "queue${var.ambiente}bra${var.azurerm_storage_account_name}_diagnostic"
  target_resource_id             = "${azurerm_storage_account.st.id}/queueServices/default/"
  partner_solution_id            = data.azurerm_elastic_cloud_elasticsearch.this[0].id
  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_log {
    category = "StorageWrite"
  }

  depends_on = [ data.azurerm_elastic_cloud_elasticsearch.this ]
}

resource "azurerm_monitor_diagnostic_setting" "table_diag" {
  count = var.ambiente == "pr" ? 1 : 0
  name                           = "table${var.ambiente}bra${var.azurerm_storage_account_name}_diagnostic"
  target_resource_id             = "${azurerm_storage_account.st.id}/tableServices/default/"
  partner_solution_id            = data.azurerm_elastic_cloud_elasticsearch.this[0].id
  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_log {
    category = "StorageWrite"
  }

  depends_on = [ data.azurerm_elastic_cloud_elasticsearch.this ]
}