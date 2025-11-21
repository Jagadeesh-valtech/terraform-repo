
//windows VM Resource
# resource "azurerm_windows_virtual_machine" "appvm" {
#   name                = var.vmname
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   size                = "Standard_B2s"
#   admin_username      = "adminuser"
#   admin_password      = "Valtech@1997"

#   network_interface_ids = [
#     var.network_interface_id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2022-Datacenter"
#     version   = "latest"
#   }
# }


# # Resource: Custom Script Extension to install IIS
# resource "azurerm_virtual_machine_extension" "iis_install" {
#   # The name of the extension running on the VM
#   name                 = "InstallIISS"
#   virtual_machine_id   = azurerm_windows_virtual_machine.appvm.id # Reference your VM resource
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10" # Use a stable version

#   settings = jsonencode({
#     # The URL received from the storage module output
#     fileUris = [var.script_url_with_sas] 
    
#     # The command to execute on the VM
#     commandToExecute = "powershell.exe -ExecutionPolicy Unrestricted -File ${var.script_file_name}"
#   })

#   # Ensure the extension runs after the VM is created
#   depends_on = [
#     azurerm_windows_virtual_machine.appvm,
#     # Add other dependencies like the NIC or Public IP if needed
#   ]
# }


//linux VM Resource

resource "azurerm_linux_virtual_machine" "linxmachines" {
  count = var.number_of_vms
  name                = "${var.vmname}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password = var.admin_password
  disable_password_authentication = false


  network_interface_ids = [
    var.network_interface_id[count.index],
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


resource "azurerm_virtual_machine_extension" "nginx_install" {
  count = var.number_of_vms
  name                 = "install-nginx"
  virtual_machine_id   = azurerm_linux_virtual_machine.linxmachines[count.index].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "fileUris": ["${var.ngnix_script_url_with_sas}"],
  "commandToExecute": "bash ${var.ngnix_file_name}"
 }
SETTINGS
  depends_on = [
    azurerm_linux_virtual_machine.linxmachines,
  ]
}

