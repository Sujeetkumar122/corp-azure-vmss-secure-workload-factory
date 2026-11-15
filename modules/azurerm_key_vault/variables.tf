variable "key_vaults" {
  description = "Map of Key Vault configurations"
  type = map(object({
    name                       = string
    location                   = string
    resource_group_name        = string
    tenant_id                  = string
    sku_name                   = string
    soft_delete_retention_days = optional(number, 7)
    purge_protection_enabled   = optional(bool, true)
    tags                       = optional(map(string), {})
  }))
}

variable "key_vault_secrets" {
  description = "Map of secrets to store in Key Vault"
  type = map(object({
    name         = string
    value        = string
    key_vault_id = string
    tags         = optional(map(string), {})
  }))
  default = {}
}

