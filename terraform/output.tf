output "azurerm_key_vault_id" {
  value       = module.key_vault.azurerm_key_vault_name.id
  description = "ID do key vault"
}

output "azurerm_key_vault_name" {
  value       = module.key_vault.azurerm_key_vault_name.name
  description = "Nome do key vault"
}

output "azurerm_key_vault_resource_group_name" {
  value       = module.key_vault.azurerm_key_vault_resource_group_name #azurerm_key_vault.this.resource_group_name
  description = "Resource Group do key vault"
}

output "azurerm_private_endpoint" {
  value = {
    id                  = azurerm_private_endpoint.this.id
    name                = azurerm_private_endpoint.this.name
    resource_group_name = azurerm_private_endpoint.this.resource_group_name
  }
}