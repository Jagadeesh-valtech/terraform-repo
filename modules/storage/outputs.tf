# output "iis_script_url_with_sas" {
#   description = "The URL to the IIS installation script, including the temporary SAS token."
#   value = "https://${data.azurerm_storage_account.storage_info.name}.blob.core.windows.net/${var.storage_contaier_name}/${azurerm_storage_blob.iis_script.name}${data.azurerm_storage_account_blob_container_sas.script_sas.sas}"
# }

# output "script_file_name" {
#   description = "The name of the PowerShell file."
#   value       = azurerm_storage_blob.iis_script.name
# }


output "ngnix_script_url_with_sas" {
  description = "The URL to the NGNIX installation script, including the temporary SAS token."
  value = "https://${data.azurerm_storage_account.storage_info.name}.blob.core.windows.net/${var.storage_contaier_name}/${azurerm_storage_blob.nginx_script.name}${data.azurerm_storage_account_blob_container_sas.ngnix_sas.sas}"
}

output "ngnix_file_name" {
  description = "The name of the PowerShell file."
  value       = azurerm_storage_blob.nginx_script.name
}