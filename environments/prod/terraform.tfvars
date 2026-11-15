environment = "prod"
location    = "eastus2"

resource_groups = {
  "security" = {
    name     = "rg-prod-security-eastus2-01"
    location = "eastus2"
    tags = {
      Environment = "prod"
      Tier        = "Security"
      Compliance  = "PCI-DSS-HIPAA"
    }
  }
  "workload" = {
    name     = "rg-prod-workload-eastus2-01"
    location = "eastus2"
    tags = {
      Environment = "prod"
      Tier        = "Workload"
      Compliance  = "PCI-DSS-HIPAA"
    }
  }
}

vnets = {
  "spoke" = {
    name                = "vnet-prod-spoke-eastus2-01"
    location            = "eastus2"
    resource_group_name = "rg-prod-workload-eastus2-01"
    address_space       = ["172.22.0.0/16"]
    tags = {
      Environment = "prod"
      Role        = "Workload"
      Compliance  = "PCI-DSS-HIPAA"
    }
  }
}

subnets = {
  "vmss" = {
    name                = "snet-prod-workload-vmss-01"
    vnet_key            = "spoke"
    resource_group_name = "rg-prod-workload-eastus2-01"
    prefix              = "172.22.1.0/24"
  }
}

key_vault_sku     = "premium"
vm_admin_username = "corpadmin"
vm_admin_password = "Pr0dEnterpriseSecureP@ssw0rd2026!#"
vmss_sku          = "Standard_D4s_v5"
vmss_instances    = 4

common_tags = {
  Environment = "prod"
  ManagedBy   = "Terraform"
  Project     = "Corporate-VMSS-Workload-Factory"
  Compliance  = "PCI-DSS-HIPAA"
}
