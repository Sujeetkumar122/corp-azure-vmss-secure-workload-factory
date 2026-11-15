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
  default = {}
}

