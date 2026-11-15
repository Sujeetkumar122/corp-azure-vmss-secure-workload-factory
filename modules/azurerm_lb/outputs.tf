output "load_balancer_ids" {
  description = "IDs of the deployed Load Balancers"
  value       = { for k, v in azurerm_lb.lb : k => v.id }
}

output "backend_pool_ids" {
  description = "IDs of the Load Balancer backend address pools"
  value       = { for k, v in azurerm_lb_backend_address_pool.pool : k => v.id }
}
