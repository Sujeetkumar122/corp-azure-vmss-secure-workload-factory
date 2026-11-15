check "environment_validation" {
  assert {
    condition     = var.environment == "dev"
    error_message = "The environment variable must be set to 'dev' for dev configuration."
  }
}

check "tags_validation" {
  assert {
    condition     = contains(keys(var.common_tags), "Environment") && contains(keys(var.common_tags), "ManagedBy")
    error_message = "Mandatory tags 'Environment' and 'ManagedBy' must be present in common_tags."
  }
}

check "vmss_instance_validation" {
  assert {
    condition     = var.vmss_instances >= 1 && var.vmss_instances <= 10
    error_message = "Development VMSS instance count must be between 1 and 10."
  }
}
