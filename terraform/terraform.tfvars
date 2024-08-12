###################################################################################
#                                        FINOPS
###################################################################################
centro_custo  = "inge_inge_infraestrutura_gerenciamento"
empresa       = "bradesco"
departamento  = "d_4250"
app           = "kit_infra_dominio"
componente    = "r2-d2"
ambiente      = "dv"
bo            = "departamento_de_infraestrutura_de_ti"
to            = "to_4250_945"
gerenciamento = "gitops"
provedor      = "azure"
dominio       = "ditiauto"


###################################################################################
#                                      KEYVAULT
###################################################################################
#virtual_network_name                = "vnetkvdevbra"
#virtual_network_resource_group_name = "rgdvditiautovnetacoe"
keyvault_subnet_name       = "subkvdevbra002"
subnet_resource_group_name = "rgkvdevbradesco001"
#azurerm_key_vault_location                      = "brazilsouth"
sku_name                              = "premium"
enabled_for_deployment                = "true"
enabled_for_disk_encryption           = "true"
enabled_for_template_deployment       = "true"
enable_rbac_authorization             = "false"
soft_delete_retention_days            = "90"
purge_protection_enabled              = "true"
public_network_access_enabled         = "true"
azurerm_key_vault_resource_group_name = "rgkvdevbradesco001"
subnet_virtual_network_name           = "vnetkvdevbra001"
azurerm_key_vault_name                = "kvazudvbraditiauto001"
#azurerm_private_endpoint_private_service_connection_name = "pvtsvcconnkv001"
azurerm_private_endpoint_name   = "pvtendpointkv001"
azurerm_private_dns_zone_name   = "privatelink.vaultcore.azure.net"
private_service_connection_name = "pvtconnectionkv001"
#private_service_connection_is_manual_connection = "false"
#private_dns_zone_group_name                     = "privatelink.redis.cache.windows.net"
azurerm_eventhub_namespace_authorization_rule_name                = "RootManageSharedAccessKey"
azurerm_eventhub_namespace_authorization_rule_resource_group_name = "rg-siem-qradar"
namespace_name                                                    = "eventhubmgmtsiemqradar"
azurerm_monitor_diagnostic_setting_name                           = "azmonitordvkv001"
eventhub_name                                                     = "ehbrmgmtsiemqradar"


###################################################################################
#                                   RESOURCE GROUP
###################################################################################
azurerm_resource_group_location = "brazilsouth"


###################################################################################
#                                   MÓDULO VNET
###################################################################################
#subnet_virtual_network_name = ""
azurerm_virtual_network_location      = "brazilsouth"
azurerm_virtual_network_address_space = ["172.30.0.0/22"]
azurerm_subnet_address_prefixes       = ["172.30.1.0/24"]
azurerm_subnet_name                   = "subkvdevbra002"


###################################################################################
#                                  MÓDULO SUBNET JUMP
###################################################################################
jump_subnet_name = "jumper-subnet"