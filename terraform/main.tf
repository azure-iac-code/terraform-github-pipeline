module "tags_finops" {
  source        = "git::https://github.com/Bradesco-IAC/trf-azu-tags-finops.git?ref=develop"
  centro_custo  = var.centro_custo
  empresa       = var.empresa
  departamento  = var.departamento
  app           = var.app
  componente    = var.componente
  ambiente      = var.ambiente
  bo            = var.bo
  to            = var.to
  gerenciamento = var.gerenciamento
  provedor      = var.provedor
  dominio       = var.dominio
}

module "resource_group" {
  source                          = "git::https://github.com/Bradesco-IAC/trf-azu-resource-group.git?ref=V1"
  azurerm_resource_group_name     = var.azurerm_key_vault_resource_group_name
  azurerm_resource_group_location = var.azurerm_resource_group_location
  tags                            = module.tags_finops.tags_finops
}

module "vnet" {
  source                                = "git::https://github.com/Bradesco-IAC/trf-azu-vnet.git?ref=V2"
  azurerm_resource_group_name           = var.azurerm_key_vault_resource_group_name
  azurerm_virtual_network_location      = var.azurerm_virtual_network_location
  azurerm_virtual_network_name          = var.subnet_virtual_network_name
  azurerm_virtual_network_address_space = var.azurerm_virtual_network_address_space
  azurerm_subnet_address_prefixes       = var.azurerm_subnet_address_prefixes
  azurerm_subnet_name                   = var.azurerm_subnet_name
  ambiente                              = var.ambiente
  depends_on                            = [module.resource_group]
}

resource "azurerm_subnet" "subnet_jump" {
  name                 = var.jump_subnet_name
  resource_group_name  = var.azurerm_key_vault_resource_group_name
  virtual_network_name = var.subnet_virtual_network_name
  address_prefixes     = ["172.30.2.0/24"]
  depends_on           = [module.resource_group]
}

data "azurerm_client_config" "current" {}

module "key_vault" {
  source                 = "git::https://github.com/Bradesco-IAC/trf-azu-key-vault.git?ref=develop"
  azurerm_key_vault_name = var.azurerm_key_vault_name
  keyvault_subnet_name   = var.keyvault_subnet_name
  ambiente               = var.ambiente
  #subnet_name                   = var.subnet_name
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
  private_service_connection_name = var.private_service_connection_name
  azurerm_private_dns_zone_name   = var.azurerm_private_dns_zone_name
  azurerm_private_endpoint_name   = var.azurerm_private_endpoint_name #"pvtkvazu${var.ambiente}bra${var.azurerm_key_vault_name}"

  ####################################################################################
  #                                DIAGNOSTIC SETTINGS
  ####################################################################################
  azurerm_eventhub_namespace_authorization_rule_name                = var.azurerm_eventhub_namespace_authorization_rule_name
  azurerm_eventhub_namespace_authorization_rule_resource_group_name = var.azurerm_eventhub_namespace_authorization_rule_resource_group_name
  namespace_name                                                    = var.namespace_name


  azurerm_monitor_diagnostic_setting_name = var.azurerm_monitor_diagnostic_setting_name #"${var.azurerm_key_vault_name}_diagnostic"
  eventhub_name                           = var.eventhub_name
  depends_on                              = [azurerm_subnet.subnet_jump]

  providers = {
    azurerm                   = azurerm
    azurerm.ditiidentity      = azurerm.ditiidentity
    azurerm.ditigerenciamento = azurerm.ditigerenciamento
  }
}