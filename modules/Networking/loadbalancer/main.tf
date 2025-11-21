resource "azurerm_public_ip" "pip_lb" {
  name                = "pip-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_lb" "app_load_balancer" {
  name                = "app-loadbalancer"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PIP-Frontend"
    public_ip_address_id = azurerm_public_ip.pip_lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.app_load_balancer.id
  name            = "LB-BackendPool"
}

resource "azurerm_lb_backend_address_pool_address" "lb_backend_pool_address" {
  count = var.number_of_subnets
  name                    = "machine-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
  virtual_network_id      = var.virtual_network_id
  ip_address              = var.network_interface_private_ip[count.index]
}

resource "azurerm_lb_probe" "lb_health_probe" {
  loadbalancer_id = azurerm_lb.app_load_balancer.id
  name            = "http-probe"
  protocol        = "Tcp"
  port            = 80
  interval_in_seconds = 5
}

resource "azurerm_lb_rule" "app-lb-rule" {
  loadbalancer_id                = azurerm_lb.app_load_balancer.id
  name                           = "app-lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.app_load_balancer.frontend_ip_configuration[0].name
  probe_id = azurerm_lb_probe.lb_health_probe.id
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
}