output "network_interface_id" {
  value = azurerm_network_interface.network_interface_config[*].id
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip[*].ip_address
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet_neu.id
}

output "network_interface_private_ip" {
  value = azurerm_network_interface.network_interface_config[*].private_ip_address
}