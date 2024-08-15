###################################################################################
#                                      FINOPS
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
#                                  RESOURCE_GROUP
###################################################################################
azurerm_resource_group_location = "brazilsouth"


###################################################################################
#                                     VNET | SUBNET
###################################################################################
azurerm_virtual_network_location      = "brazilsouth"
azurerm_virtual_network_address_space = ["172.30.0.0/22"]
azurerm_subnet_address_prefixes       = ["172.30.1.0/24"]
keyvault_subnet_name                  = "snetdvditiautodvptendpoint001"


###################################################################################
#                                      KEYVAULT
###################################################################################
azurerm_subnet_name                                               = "subkvdevbra001"
subnet_resource_group_name                                        = "rgdvditiautovnetacoe"
sku_name                                                          = "premium"
enabled_for_deployment                                            = "true"
enabled_for_disk_encryption                                       = "true"
enabled_for_template_deployment                                   = "true"
enable_rbac_authorization                                         = "false"
soft_delete_retention_days                                        = "90"
purge_protection_enabled                                          = "true"
public_network_access_enabled                                     = "true"
azurerm_key_vault_resource_group_name                             = "rgkvdevbradesco001"
subnet_virtual_network_name                                       = "vnetdvditiautoacoebrazilsouth"
azurerm_key_vault_name                                            = "kvazudvbraditiauto004"
azurerm_eventhub_namespace_authorization_rule_name                = "RootManageSharedAccessKey"
azurerm_eventhub_namespace_authorization_rule_resource_group_name = "rg-siem-qradar"
namespace_name                                                    = "eventhubmgmtsiemqradar"
eventhub_name                                                     = "ehbrmgmtsiemqradar"