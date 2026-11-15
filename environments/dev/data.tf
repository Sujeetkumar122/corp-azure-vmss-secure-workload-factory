# ==============================================================================
# DATA BLOCKS: Dynamic tenant, subscription, and credential metadata
# ==============================================================================

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}
