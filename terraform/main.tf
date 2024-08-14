data "azurerm_resource_group" "rg_keyvault" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet_keyvault" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet_keyvault" {
  name                 = var.azurerm_subnet_keyvault_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "subnet_jump" {
  name                 = var.azurerm_subnet_jump_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name

}

##data "azurerm_client_config" "current" {}



# module "tags_finops" {
#   source        = "git::https://github.com/azure-iac-code/trf-azu-keyvault.git"
#   centro_custo  = var.centro_custo
#   empresa       = var.empresa
#   departamento  = var.departamento
#   app           = var.app
#   componente    = var.componente
#   ambiente      = var.ambiente
#   bo            = var.bo
#   to            = var.to
#   gerenciamento = var.gerenciamento
#   provedor      = var.provedor
#   dominio       = var.dominio
# }

# module "resource_group" {
#   source                          = "git::https://github.com/azure-iac-code/trf-azu-keyvault.git"
#   resource_group_name     = var.azurerm_key_vault_resource_group_name
#   azurerm_resource_group_location = var.azurerm_resource_group_location
#   tags                            = module.tags_finops.tags_finops
# }

# module "vnet" {
#   source                                = "git::https://github.com/azure-iac-code/trf-azu-keyvault.git"
#   resource_group_name           = var.azurerm_key_vault_resource_group_name
#   azurerm_virtual_network_location      = var.azurerm_virtual_network_location
#   virtual_network_name          = var.subnet_virtual_network_name
#   azurerm_virtual_network_address_space = var.azurerm_virtual_network_address_space
#   azurerm_subnet_address_prefixes       = var.azurerm_subnet_address_prefixes
#   azurerm_subnet_name                   = var.azurerm_subnet_name
#   ambiente                              = var.ambiente
#   depends_on                            = [module.resource_group]
# }
#

module "key_vault" {
  source                                = "git::https://github.com/azure-iac-code/trf-azu-keyvault.git?ref=main"
  azurerm_key_vault_name                = var.azurerm_key_vault_name
  ambiente                              = var.ambiente
  subnet_resource_group_name            = var.subnet_resource_group_name
  azurerm_key_vault_resource_group_name = var.azurerm_key_vault_resource_group_name
  subnet_virtual_network_name           = var.subnet_virtual_network_name
  sku_name                              = var.sku_name
  enabled_for_deployment                = var.enabled_for_deployment
  enabled_for_disk_encryption           = var.enabled_for_disk_encryption
  enabled_for_template_deployment       = var.enabled_for_template_deployment
  enable_rbac_authorization             = var.enable_rbac_authorization
  soft_delete_retention_days            = var.soft_delete_retention_days
  purge_protection_enabled              = var.purge_protection_enabled
  public_network_access_enabled         = var.public_network_access_enabled


  ##################################################################################
  #                                  PRIVATE ENDPOINT
  ##################################################################################
  #private_service_connection_name = var.private_service_connection_name
  azurerm_private_dns_zone_name = var.azurerm_private_dns_zone_name

  ####################################################################################
  #                                DIAGNOSTIC SETTINGS
  ####################################################################################
  azurerm_eventhub_namespace_authorization_rule_name                = var.azurerm_eventhub_namespace_authorization_rule_name
  azurerm_eventhub_namespace_authorization_rule_resource_group_name = var.azurerm_eventhub_namespace_authorization_rule_resource_group_name
  namespace_name                                                    = var.namespace_name


  azurerm_monitor_diagnostic_setting_name = "${var.azurerm_key_vault_name}_diagnostic"
  eventhub_name                           = var.eventhub_name
  depends_on                              = [module.vnet]

  #   providers = {
  #     azurerm                   = azurerm
  #     azurerm.ditiidentity      = azurerm.ditiidentity
  #     azurerm.ditigerenciamento = azurerm.ditigerenciamento
  #   }
}