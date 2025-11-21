resource "null_resource" "add_file" {
    count = var.number_of_vms
    provisioner "file" {
      content = "<h1> Welcome to Nginx Server ${azurerm_linux_virtual_machine.linxmachines[count.index].computer_name} </h1>"
      destination = "/home/adminuser/Default.html"

      connection {
        type = "ssh"
        user = "adminuser"
        password = var.admin_password
        host = var.public_ip_address[count.index]
      }
    }

      provisioner "remote-exec" {

        connection {
        type = "ssh"
        user = "adminuser"
        password = var.admin_password
        host = var.public_ip_address[count.index]
      }
        inline = [
          "sudo mv /home/adminuser/Default.html /var/www/html/Default.html"]
    } 

    depends_on = [ azurerm_linux_virtual_machine.linxmachines, azurerm_virtual_machine_extension.nginx_install ]
}