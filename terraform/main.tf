# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0.2"
#     }
#   }
#   required_version = ">= 1.1.0"
# }

# provider "azurerm" {
#   features {}
# }

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "this" {
  name = "rg-keyvault"
}

data "azurerm_virtual_network" "this" {
  name                = "vnet-keyvault"
  resource_group_name = data.azurerm_resource_group.this.name
  depends_on          = [data.azurerm_resource_group.this]
}

data "azurerm_subnet" "keyvault_subnet" {
  name                 = "keyvault_subnet"
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
  depends_on           = [data.azurerm_resource_group.this]
}

data "azurerm_subnet" "jump_subnet" {
  name                 = "jump_subnet"
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
  depends_on           = [data.azurerm_resource_group.this]
}

resource "azurerm_key_vault" "this" {
  name                            = var.azurerm_key_vault_name
  location                        = var.azurerm_key_vault_location
  resource_group_name             = var.azurerm_key_vault_resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  #public_network_access_enabled   = var.public_network_access_enabled
  # soft_delete_enabled      = true
  # purge_protection_enabled = true
  #private_endpoint_enabled = true

  network_acls {
    bypass                     = var.network_acls_bypass
    default_action             = var.network_acls_default_action
    virtual_network_subnet_ids = [data.azurerm_subnet.keyvault_subnet.id, data.azurerm_subnet.jump_subnet.id]
    ip_rules                   = var.network_acls_ip_rules
  }

  # access_policy {
  #   tenant_id               = data.azurerm_client_config.current.tenant_id
  #   object_id               = azurerm_key_vault_access_policy.this.object_id #azurerm_key_vault_access_policy.this.id
  #   key_permissions         = ["Get", "List"]
  #   secret_permissions      = ["Get", "List"]
  #   certificate_permissions = ["Get", "List"]
  # }
}

#----------------------------------------
# Recurso privateEndPoint
#----------------------------------------
resource "azurerm_private_endpoint" "this" {
  depends_on          = [azurerm_key_vault.this]
  name                = "pvtkvazu${var.ambiente}bra${var.azurerm_key_vault_name}"
  resource_group_name = var.azurerm_key_vault_resource_group_name
  location            = var.azurerm_key_vault_location
  subnet_id           = data.azurerm_subnet.keyvault_subnet.id

  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_key_vault_name}"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = var.private_service_connection_is_manual_connection
    subresource_names              = ["vault"]
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id            = azurerm_key_vault.this.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_client_config.current.object_id
  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  depends_on = [data.azurerm_client_config.current]
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

# resource "azurerm_role_assignment" "this" {
#   scope                = azurerm_key_vault.this.id
#   role_definition_name = "Key Vault Reader"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

# resource "azurerm_role_assignment" "this" {
#   scope                = azurerm_key_vault.this.id
#   role_definition_name = "Security Admin"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

# resource "azurerm_role_assignment" "this" {
#   scope                = azurerm_key_vault.this.id
#   role_definition_name = "Security Reader"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

# resource "azurerm_key_vault_diagnostic_setting" "this" {
#   name                            = "this-diagnostic-setting"
#   key_vault_id                    = azurerm_key_vault.this.id
#   event_hub_name                  = "eventhubmgmtsiemqradar"
#   event_hub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.this.id
#   logs {
#     category = "AuditEvent"
#     enabled  = true
#   }
# }

# resource "azurerm_eventhub_namespace_authorization_rule" "this" {
#   name                = "this-authorization-rule"
#   namespace_name      = "eventhubmgmtsiemqradar"
#   resource_group_name = azurerm_resource_group.this.name
#   eventhub_name       = azurerm_eventhub.this.name
#   Listen              = true
#   send                = true
#   manage              = true
# }

# resource "azurerm_eventhub" "this" {
#   name                = "this-eventhub"
#   namespace_name      = azurerm_eventhub_namespace.this.name
#   resource_group_name = azurerm_resource_group.this.name
#   partition_count     = 2
#   message_retention   = 1
# }

# resource "azurerm_eventhub_consumer_group" "this" {
#   name                = "this-consumer-group"
#   eventhub_name       = azurerm_eventhub.this.name
#   namespace_name      = azurerm_eventhub_namespace.this.name
#   resource_group_name = azurerm_resource_group.this.name
# }
#