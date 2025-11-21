resource "azurerm_virtual_network" "vnet_neu" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_prefix
}

resource "azurerm_subnet" "snet_neu" {
    count = var.number_of_subnets
    name             = "${var.snet_name}-${count.index + 1}"
    resource_group_name = var.resource_group_name
    address_prefixes = [var.snet_address_prefixes[count.index]]
    virtual_network_name = azurerm_virtual_network.vnet_neu.name
}

resource "azurerm_network_security_group" "network_security_rule" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
resource "azurerm_network_security_rule" "AllowSSH" {
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_rule.name
}

resource "azurerm_network_security_rule" "AllowHTTP" {
  name                        = "Allow-HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_rule.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_snet_neu" {
  count = var.number_of_subnets
  subnet_id                 = azurerm_subnet.snet_neu[count.index].id
  network_security_group_id = azurerm_network_security_group.network_security_rule.id
}

resource "azurerm_network_interface" "network_interface_config" {
  count = var.number_of_subnets
  name                = "${var.network_interface_name}-${count.index + 1}" 
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet_neu[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_public_ip" "public_ip" {
  count = var.number_of_subnets
  name                = "${var.public_ip_name}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}
