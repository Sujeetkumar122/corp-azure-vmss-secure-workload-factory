check "environment_validation" {
  assert {
    condition     = var.environment == "prod"
    error_message = "The environment variable must be set to 'prod' for production configuration."
  }
}

check "tags_validation" {
  assert {
    condition     = contains(keys(var.common_tags), "Environment") && contains(keys(var.common_tags), "Compliance")
    error_message = "Mandatory tags 'Environment' and 'Compliance' must be present in production common_tags."
  }
}

check "vmss_instance_validation" {
  assert {
    condition     = var.vmss_instances >= 2
    error_message = "Production VMSS instance count must be at least 2 for High Availability."
  }
}
