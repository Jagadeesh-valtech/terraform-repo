module "dev-resource-group" {
  source = "../../modules/general/resourcegroup"
  resource_group_name = var.resource_group
  location = var.location
}

module "storageaccont" {
  source = "../../modules/storage"
  location = var.location
  resource_group_name = var.resource_group
  storage_account_name = "tfdevstorage1997"
  storage_contaier_name = "scripts"
}

module "networking"{
  source = "../../modules/Networking/vnet"
  location = var.location
  resource_group_name = var.resource_group
  vnet_name = "dev_vnet"
  vnet_address_prefix = ["10.0.0.0/16"]
  number_of_subnets = 2
  snet_name = "dev_snet"
  public_ip_name = "dev_public_ip"
  nsg_name = "dev_nsg"
  network_interface_name = "dev_nic"
  snet_address_prefixes = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]

  depends_on = [ module.dev-resource-group ]
}

module "virtual-machines" {
  source = "../../modules/compute/virtualmachines"
  location = var.location
  resource_group_name = var.resource_group
  vmname = "devvm"
  network_interface_id = module.networking.network_interface_id
  # script_url_with_sas = module.storageaccont.iis_script_url_with_sas
  # script_file_name = module.storageaccont.script_file_name
  number_of_vms = 2
  admin_password = var.admin_password
  ngnix_file_name = module.storageaccont.ngnix_file_name
  ngnix_script_url_with_sas = module.storageaccont.ngnix_script_url_with_sas
  public_ip_address = module.networking.public_ip_address

  depends_on = [ module.dev-resource-group, module.networking, module.storageaccont ]
}
