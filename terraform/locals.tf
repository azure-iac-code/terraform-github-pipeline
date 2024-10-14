locals {
  network_subnets = var.azurerm_storage_account_type == "DATALAKE" ? tolist([data.azurerm_subnet.subnet.id]) : tolist([data.azurerm_subnet.subnet.id])
}


locals {
  location                 = "East US"
  account_tier             = var.ambiente == "dv" ? "Standard" : "Premium"
  account_replication_type = var.ambiente == "dv" ? "LRS" : "ZRS"
}