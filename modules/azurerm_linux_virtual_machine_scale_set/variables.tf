variable "scale_sets" {
  description = "Map of Linux VM Scale Sets (VMSS) to deploy"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    sku                      = string
    instances                = optional(number, 2)
    admin_username           = string
    admin_password           = string
    subnet_id                = string
    backend_address_pool_ids = optional(list(string), [])
    storage_account_type     = optional(string, "Standard_LRS")
    os_disk_caching          = optional(string, "ReadWrite")
    image_publisher          = optional(string, "Canonical")
    image_offer              = optional(string, "0001-com-ubuntu-server-jammy")
    image_sku                = optional(string, "22_04-lts")
    image_version            = optional(string, "latest")
    tags                     = optional(map(string), {})
  }))
}

