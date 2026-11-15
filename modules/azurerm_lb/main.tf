resource "azurerm_lb" "lb" {
  for_each = var.load_balancers

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  frontend_ip_configuration {
    name                          = "LoadBalancerFrontend"
    public_ip_address_id          = each.value.public_ip_address_id
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }

  tags = each.value.tags
}

resource "azurerm_lb_backend_address_pool" "pool" {
  for_each = var.load_balancers

  name            = "LoadBalancerBackendPool"
  loadbalancer_id = azurerm_lb.lb[each.key].id
}

resource "azurerm_lb_probe" "probe" {
  for_each = var.load_balancers

  name            = "HealthProbe"
  loadbalancer_id = azurerm_lb.lb[each.key].id
  port            = each.value.probe_port
  protocol        = each.value.probe_protocol
  request_path    = each.value.probe_path
}

resource "azurerm_lb_rule" "rule" {
  for_each = var.load_balancers

  name                           = "LBRule-HTTP"
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = "LoadBalancerFrontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool[each.key].id]
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}
