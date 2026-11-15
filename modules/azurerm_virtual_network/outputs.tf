output "vnet_ids" {
  description = "IDs of the deployed Virtual Networks"
  value       = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "vnet_names" {
  description = "Names of the deployed Virtual Networks"
  value       = { for k, v in azurerm_virtual_network.vnet : k => v.name }
}

output "subnet_ids" {
  description = "IDs of the deployed subnets"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}

