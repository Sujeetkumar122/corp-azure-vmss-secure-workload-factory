output "resource_group_names" {
  description = "Names of the deployed resource groups"
  value       = module.resource_groups.resource_group_names
}

output "virtual_network_ids" {
  description = "IDs of the deployed virtual networks"
  value       = module.virtual_networks.vnet_ids
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.virtual_networks.subnet_ids
}

output "load_balancer_id" {
  description = "ID of the deployed internal load balancer"
  value       = module.load_balancers.load_balancer_ids["int-lb"]
}

output "key_vault_uri" {
  description = "URI of the deployed Key Vault"
  value       = module.key_vaults.key_vault_uris["sec-kv"]
}

output "scale_set_id" {
  description = "ID of the deployed VM Scale Set"
  value       = module.scale_sets.scale_set_ids["workload-vmss"]
}

output "scale_set_name" {
  description = "Name of the deployed VM Scale Set"
  value       = module.scale_sets.scale_set_names["workload-vmss"]
}
