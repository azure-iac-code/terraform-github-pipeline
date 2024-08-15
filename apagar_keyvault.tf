resource "azurerm_key_vault" "example" {
  name                     = "example-keyvault"
  location                 = "eastus"
  resource_group_name      = azurerm_resource_group.example.name
  sku_name                 = "standard"
  tenant_id                = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled      = true
  purge_protection_enabled = true
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = ["200.155.87.0/24"]
  }
  private_endpoint_enabled = true
  private_endpoint_connections {
    name                = "example-private-endpoint"
    private_endpoint_id = azurerm_private_endpoint.example.id
    subresource_names   = ["vault"]
  }
  access_policy {
    tenant_id               = data.azurerm_client_config.current.tenant_id
    object_id               = azurerm_key_vault_access_policy.example.id
    key_permissions         = ["get", "list"]
    secret_permissions      = ["get", "list"]
    certificate_permissions = ["get", "list"]
  }
}

resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id            = azurerm_key_vault.example.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_key_vault_access_policy.example.id
  key_permissions         = ["get", "list"]
  secret_permissions      = ["get", "list"]
  certificate_permissions = ["get", "list"]
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Security Admin"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Security Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_diagnostic_setting" "example" {
  name                            = "example-diagnostic-setting"
  key_vault_id                    = azurerm_key_vault.example.id
  event_hub_name                  = "eventhubmgmtsiemqradar"
  event_hub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.example.id
  logs {
    category = "AuditEvent"
    enabled  = true
  }
}

resource "azurerm_eventhub_namespace_authorization_rule" "example" {
  name                = "example-authorization-rule"
  namespace_name      = "eventhubmgmtsiemqradar"
  resource_group_name = azurerm_resource_group.example.name
  eventhub_name       = azurerm_eventhub.example.name
  listen              = true
  send                = true
  manage              = true
}

resource "azurerm_eventhub" "example" {
  name                = "example-eventhub"
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = azurerm_resource_group.example.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_consumer_group" "example" {
  name                = "example-consumer-group"
  eventhub_name       = azurerm_eventhub.example.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = azurerm_resource_group.example.name
}