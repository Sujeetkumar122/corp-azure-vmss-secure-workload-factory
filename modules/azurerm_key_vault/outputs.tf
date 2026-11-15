output "key_vault_ids" {
  description = "IDs of the deployed Key Vaults"
  value       = { for k, v in azurerm_key_vault.kv : k => v.id }
}

output "key_vault_uris" {
  description = "Vault URIs of the deployed Key Vaults"
  value       = { for k, v in azurerm_key_vault.kv : k => v.vault_uri }
}

output "secret_ids" {
  description = "IDs of the deployed secrets"
  value       = { for k, v in azurerm_key_vault_secret.secret : k => v.id }
}

