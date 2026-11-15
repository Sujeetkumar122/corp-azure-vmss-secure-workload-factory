variable "load_balancers" {
  description = "Map of Azure Load Balancers to deploy"
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    sku                           = optional(string, "Standard")
    public_ip_address_id          = optional(string)
    subnet_id                     = optional(string)
    private_ip_address_allocation = optional(string, "Dynamic")
    probe_port                    = optional(number, 80)
    probe_protocol                = optional(string, "Http")
    probe_path                    = optional(string, "/health")
    frontend_port                 = optional(number, 80)
    backend_port                  = optional(number, 80)
    tags                          = optional(map(string), {})
  }))
}
