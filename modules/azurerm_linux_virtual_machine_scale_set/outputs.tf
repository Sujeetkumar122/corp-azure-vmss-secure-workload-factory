output "scale_set_ids" {
  description = "IDs of the deployed VM Scale Sets"
  value       = { for k, v in azurerm_linux_virtual_machine_scale_set.vmss : k => v.id }
}

output "scale_set_names" {
  description = "Names of the deployed VM Scale Sets"
  value       = { for k, v in azurerm_linux_virtual_machine_scale_set.vmss : k => v.name }
}

