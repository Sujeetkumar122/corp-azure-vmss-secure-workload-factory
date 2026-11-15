environment = "dev"
location    = "eastus2"

resource_groups = {
  "security" = {
    name     = "rg-dev-security-eastus2-01"
    location = "eastus2"
    tags = {
      Environment = "dev"
      Tier        = "Security"
    }
  }
  "workload" = {
    name     = "rg-dev-workload-eastus2-01"
    location = "eastus2"
    tags = {
      Environment = "dev"
      Tier        = "Workload"
    }
  }
}

vnets = {
  "spoke" = {
    name                = "vnet-dev-spoke-eastus2-01"
    location            = "eastus2"
    resource_group_name = "rg-dev-workload-eastus2-01"
    address_space       = ["10.20.0.0/16"]
    tags = {
      Environment = "dev"
      Role        = "Workload"
    }
  }
}

subnets = {
  "vmss" = {
    name                = "snet-dev-workload-vmss-01"
    vnet_key            = "spoke"
    resource_group_name = "rg-dev-workload-eastus2-01"
    prefix              = "10.20.1.0/24"
  }
}

key_vault_sku     = "standard"
vm_admin_username = "azureuser"
vm_admin_password = "P@ssw0rdDevVmssWorkload2026!"
vmss_sku          = "Standard_B2s"
vmss_instances    = 2

common_tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "Corporate-VMSS-Workload-Factory"
}
