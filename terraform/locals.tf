locals {
    location                  = "brazilsouth"
    account_tier              = var.ambiente == "dv" ? "Standard" : "Premium"
    account_replication_type  = var.ambiente == "dv" ? "LRS" : "ZRS"
}