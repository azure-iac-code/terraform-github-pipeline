#-------------------------------------------
# Data do recurso vnet e subnet jump
#-------------------------------------------

data "azurerm_virtual_network" "this" {
  name                = var.azurerm_virtual_network_name
  resource_group_name = var.azurerm_resource_group_name
 # provider            = azurerm.ditigerenciamento
}

data "azurerm_subnet" "svc_endpoint_subnet" {
  name                 = var.jump_subnet_name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = var.azurerm_resource_group_name
#  provider             = azurerm.ditigerenciamento
}

data "azurerm_subnet" "keyvault_subnet" {
  name                 = var.keyvault_subnet_name
  virtual_network_name = var.azurerm_virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}

data "azurerm_client_config" "this" {}

#---------------------------------------
# Data do recurso vnet e subnet
#---------------------------------------

data "azurerm_private_dns_zone" "this" {
  name                = var.azurerm_private_dns_zone_name
  resource_group_name = var.azurerm_private_dns_zone_resource_group_name
#  provider            = azurerm.ditiidentity
}

#----------------------------------------
# Recurso keyvault
#----------------------------------------

resource "azurerm_key_vault" "this" {
  name                            = "kvazu${var.ambiente}bra${var.azurerm_key_vault_name}" #var.azurerm_key_vault_name
  location                        = var.azurerm_key_vault_location
  resource_group_name             = var.azurerm_key_vault_resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_client_config.this.tenant_id #"ccd25372-eb59-436a-ad74-78a49d784cf3"
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
#  provider                        = azurerm

  network_acls {
    bypass                     = var.network_acls_bypass
    default_action             = var.network_acls_default_action
    virtual_network_subnet_ids = [data.azurerm_subnet.keyvault_subnet.id, data.azurerm_subnet.jump_subnet.id] #, data.azurerm_subnet.bamboo_subnet.id]
    ip_rules                   = var.network_acls_ip_rules
  }
}

#----------------------------------------
# Recurso privateEndPoint
#----------------------------------------

resource "azurerm_private_endpoint" "this" {
  depends_on = [azurerm_key_vault.this]
  name                = "pvtkvazu${var.ambiente}bra${var.azurerm_key_vault_name}" #var.azurerm_private_endpoint_name 
  resource_group_name = var.azurerm_key_vault_resource_group_name
  location            = var.azurerm_key_vault_location
  subnet_id           = data.azurerm_subnet.keyvault_subnet.id
#  provider            = azurerm

  private_service_connection {
    name                           = "pvtcn${var.ambiente}bra${var.azurerm_key_vault_name}" #var.private_service_connection_name 
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = var.private_service_connection_is_manual_connection
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.this.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }
}

#----------------------------------------
# Diagnostic Settings
#----------------------------------------

data "azurerm_eventhub_namespace_authorization_rule" "this" {
  name                = var.azurerm_eventhub_namespace_authorization_rule_name
  resource_group_name = var.azurerm_eventhub_namespace_authorization_rule_resource_group_name
  namespace_name      = var.namespace_name
#  provider            = azurerm.ditigerenciamento
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                           = "${var.azurerm_key_vault_name}_diagnostic" #var.azurerm_monitor_diagnostic_setting_name
  target_resource_id             = azurerm_key_vault.this.id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.this.id

  enabled_log {
    category_group = "audit"
  }

#  provider = azurerm
}