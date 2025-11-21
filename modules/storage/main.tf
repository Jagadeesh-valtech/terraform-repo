resource "azurerm_storage_account" "valtechstorage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "scripts" {
  name                  = var.storage_contaier_name
  storage_account_id    = azurerm_storage_account.valtechstorage.id
  container_access_type = "private"
}

# resource "azurerm_storage_blob" "iis_script" {
#   name                   = "install_iis.ps1"
#   storage_account_name   = azurerm_storage_account.valtechstorage.name
#   storage_container_name = azurerm_storage_container.scripts.name
#   type                   = "Block"
#   source                 = "${path.module}/install_iis.ps1"
# }

resource "azurerm_storage_blob" "nginx_script" {
  name                   = "setup_nginx.sh"
  storage_account_name   = azurerm_storage_account.valtechstorage.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source                 = "${path.module}/setup-nginx.sh"
}


data "azurerm_storage_account" "storage_info" {
  name                = azurerm_storage_account.valtechstorage.name
  resource_group_name = var.resource_group_name
}

# # Generate the SAS token for the container holding the script
# data "azurerm_storage_account_blob_container_sas" "script_sas" {
#   connection_string = azurerm_storage_account.valtechstorage.primary_connection_string
#   container_name    = azurerm_storage_container.scripts.name
#   https_only        = true

#   start  = "2025-11-19"
#   expiry = "2025-11-25"

#   permissions {
#     read   = true
#     add    = true
#     create = false
#     write  = false
#     delete = true
#     list   = true
#   }

#   cache_control       = "max-age=5"
#   content_disposition = "inline"
#   content_encoding    = "deflate"
#   content_language    = "en-US"
#   content_type        = "application/json"

# }

#SAS for install nqinx script
data "azurerm_storage_account_blob_container_sas" "ngnix_sas" {
  connection_string = azurerm_storage_account.valtechstorage.primary_connection_string
  container_name    = azurerm_storage_container.scripts.name
  https_only        = true

  start  = "2025-11-17"
  expiry = "2025-11-25"

  permissions {
    read   = true
    add    = true
    create = false
    write  = false
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"

}