data "azurerm_resource_group" "this" {
  name = "rgdvtesteditiautoacoe"
}

resource "azurerm_storage_account" "this" {
  name                     = "stazudvbraautditi312"
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #public_network_access_enabled = false
  allow_nested_items_to_be_public = var.azurerm_storage_account_allow_nested_items_to_be_public
  depends_on                      = [data.azurerm_resource_group.this]

  network_rules {
    default_action             = var.network_rules_action
    virtual_network_subnet_ids = local.network_subnets
    ip_rules                   = var.ambiente == "dv" ? ["200.155.87.0/24"] : var.network_rules_CIDRproxy
    bypass                     = ["Metrics", "AzureServices", "Logging"]
  }
}

resource "azurerm_role_assignment" "queue" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_queue" "this" {
  name                 = "queue-312"
  storage_account_name = azurerm_storage_account.this.name
  depends_on           = [azurerm_storage_account.this]
}
#