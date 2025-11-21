location_name = "northeurope" 
resource_group_name = "rg-north-europe"


vnet_name = "vnet-neu"
vnet_address_prefix = [ "10.0.0.0/16" ]
snet_name = "snet-neu"
number_of_subnets = 2
snet_address_prefixes = [ "10.0.0.0/24", "10.0.1.0/24" ]
nsg_name = "app-nsg"

network_interface_name = "nic-neu"
vmname = "appvm"

public_ip_name = "pip"

storage_account_name = "valtech102021"
storage_contaier_name = "scripts"