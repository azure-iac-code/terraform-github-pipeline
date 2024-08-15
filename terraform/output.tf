output "azurerm_key_vault_id" {
  value       = azurerm_key_vault.this.id
  description = "ID do key vault"
}

output "azurerm_key_vault_name" {
  value       = azurerm_key_vault.this.name
  description = "Nome do key vault"
}

output "azurerm_key_vault_resource_group_name" {
  value       = azurerm_key_vault.this.resource_group_name
  description = "Resource Group do key vault"
}

output "azurerm_private_endpoint" {
  value = {
    id                  = azurerm_private_endpoint.this.id
    name                = azurerm_private_endpoint.this.name
    resource_group_name = azurerm_private_endpoint.this.resource_group_name
  }
}