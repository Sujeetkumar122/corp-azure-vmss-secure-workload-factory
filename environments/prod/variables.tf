variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "eastus2"
}

variable "resource_groups" {
  description = "Map of resource groups to deploy"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "vnets" {
  description = "Map of virtual networks to deploy"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string), {})
  }))
}

variable "subnets" {
  description = "Map of subnets to deploy"
  type = map(object({
    name                = string
    vnet_key            = string
    resource_group_name = string
    prefix              = string
  }))
}

variable "key_vault_sku" {
  description = "SKU for Key Vault"
  type        = string
  default     = "premium"
}

variable "vm_admin_username" {
  description = "Administrator username for VMSS"
  type        = string
  default     = "corpadmin"
}

variable "vm_admin_password" {
  description = "Administrator password for VMSS"
  type        = string
  sensitive   = true
}

variable "vmss_sku" {
  description = "VMSS Instance SKU"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "vmss_instances" {
  description = "Number of VMSS instances"
  type        = number
  default     = 4
}

variable "common_tags" {
  description = "Baseline metadata tags"
  type        = map(string)
  default = {
    Environment = "prod"
    ManagedBy   = "Terraform"
    Project     = "Corporate-VMSS-Workload-Factory"
    Compliance  = "PCI-DSS-HIPAA"
  }
}
