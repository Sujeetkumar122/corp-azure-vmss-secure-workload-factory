# ==============================================================================
# Linux VMSS Secure Workload Orchestration - Development
# ==============================================================================

# 1. Resource Groups
module "resource_groups" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

# 2. Virtual Networks & Subnets
module "virtual_networks" {
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets
  subnets    = var.subnets
  depends_on = [module.resource_groups]
}

# 3. Internal Load Balancer
module "load_balancers" {
  source = "../../modules/azurerm_lb"
  load_balancers = {
    "int-lb" = {
      name                          = "lb-${var.environment}-int-01"
      location                      = var.location
      resource_group_name           = module.resource_groups.resource_group_names["workload"]
      sku                           = "Standard"
      subnet_id                     = module.virtual_networks.subnet_ids["vmss"]
      private_ip_address_allocation = "Dynamic"
      probe_port                    = 80
      probe_protocol                = "Http"
      probe_path                    = "/health"
      frontend_port                 = 80
      backend_port                  = 80
      tags                          = var.common_tags
    }
  }
  depends_on = [module.virtual_networks]
}

# 4. Key Vault Security & Credentials
module "key_vaults" {
  source = "../../modules/azurerm_key_vault"
  key_vaults = {
    "sec-kv" = {
      name                       = "kv-${var.environment}-vmss-fac-01"
      location                   = var.location
      resource_group_name        = module.resource_groups.resource_group_names["security"]
      tenant_id                  = data.azurerm_client_config.current.tenant_id
      sku_name                   = var.key_vault_sku
      soft_delete_retention_days = 7
      purge_protection_enabled   = true
      tags                       = var.common_tags
    }
  }
  key_vault_secrets = {
    "vmss-pwd" = {
      name         = "${var.environment}-vmss-admin-password"
      value        = var.vm_admin_password
      key_vault_id = module.key_vaults.key_vault_ids["sec-kv"]
      tags         = var.common_tags
    }
  }
  depends_on = [module.resource_groups]
}

# 5. Linux VM Scale Set (VMSS) attached to Load Balancer backend pool
module "scale_sets" {
  source = "../../modules/azurerm_linux_virtual_machine_scale_set"
  scale_sets = {
    "workload-vmss" = {
      name                     = "vmss-${var.environment}-workload-01"
      resource_group_name      = module.resource_groups.resource_group_names["workload"]
      location                 = var.location
      sku                      = var.vmss_sku
      instances                = var.vmss_instances
      admin_username           = var.vm_admin_username
      admin_password           = var.vm_admin_password
      subnet_id                = module.virtual_networks.subnet_ids["vmss"]
      backend_address_pool_ids = [module.load_balancers.backend_pool_ids["int-lb"]]
      storage_account_type     = "Standard_LRS"
      tags                     = var.common_tags
    }
  }
  depends_on = [module.virtual_networks, module.load_balancers, module.key_vaults]
}
