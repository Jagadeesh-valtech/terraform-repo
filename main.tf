module "resource-group" {
  source = "./modules/general/resourcegroup"
  location = var.location_name
  resource_group_name = var.resource_group_name
}

module "storage" {
  source = "./modules/storage"
  resource_group_name = var.resource_group_name
  location = var.location_name
  storage_account_name = var.storage_account_name
  storage_contaier_name = var.storage_contaier_name


  depends_on = [ module.resource-group ]
}


# module "network" {
#   source = "./modules/Networking/vnet"
#   location = var.location_name
#   resource_group_name = var.resource_group_name
#   vnet_name = var.vnet_name
#   vnet_address_prefix = var.vnet_address_prefix
#   number_of_subnets = var.number_of_subnets
#   snet_name = var.snet_name
#   snet_address_prefixes = var.snet_address_prefixes
#   nsg_name = var.nsg_name
#   network_interface_name = var.network_interface_name
#   public_ip_name = var.public_ip_name

#   depends_on = [ module.resource-group ]
# }

# module "virtualmachine" {
#   source = "./modules/compute/virtualmachines"
#   location = var.location_name
#   resource_group_name = var.resource_group_name
#   vmname = var.vmname
#   network_interface_id = module.network.network_interface_id
#   script_url_with_sas = module.storage.iis_script_url_with_sas
#   script_file_name = module.storage.script_file_name
#   number_of_subnets = var.number_of_subnets
#   ngnix_file_name = module.storage.ngnix_file_name
#   ngnix_script_url_with_sas = module.storage.ngnix_script_url_with_sas
#   public_ip_address = module.network.public_ip_address

#   depends_on = [ module.resource-group, module.network, module.storage ]
  
# }

# module "load-balancer" {
#   source = "./modules/Networking/loadbalancer"
#   resource_group_name = var.resource_group_name
#   location = var.location_name
#   virtual_network_id = module.network.virtual_network_id
#   network_interface_private_ip = module.network.network_interface_private_ip
#   number_of_subnets = var.number_of_subnets
# }