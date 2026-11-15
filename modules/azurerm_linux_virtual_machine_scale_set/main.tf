resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  for_each = var.scale_sets

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  instances           = each.value.instances
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password

  disable_password_authentication = false

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  os_disk {
    storage_account_type = each.value.storage_account_type
    caching              = each.value.os_disk_caching
  }

  network_interface {
    name    = "${each.value.name}-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = each.value.subnet_id
      load_balancer_backend_address_pool_ids = each.value.backend_address_pool_ids
    }
  }

  tags = each.value.tags
}

