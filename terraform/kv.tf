# Contains the configuration to make a key vault in MS Azure to store the ADO Personal Access Token

# Create the Resource Group
resource "azurerm_resource_group" "cfp_demo_rg" {
  name     = var.rg_name
  location = var.location
}

data "azurerm_client_config" "current" {}

resource "random_string" "azurerm_key_vault_name" {
  length  = 15
  lower   = true
  numeric = true
  special = false
  upper   = true
}

locals {
  current_user_id = coalesce(var.msi_id, data.azurerm_client_config.current.object_id)
}

resource "azurerm_key_vault" "cfp_demo_kv" {
  name                            = var.cfg_demo_kv
  location                        = azurerm_resource_group.cfp_demo_rg.location
  resource_group_name             = azurerm_resource_group.cfp_demo_rg.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.kv_sku_name
  enabled_for_template_deployment = true
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get,"
    ]

    secret_permissions = [
      "Get,"
    ]

    storage_permissions = [
      "Get,"
    ]
  }

  depends_on = [
    azurerm_resource_group.cfp_demo_rg
  ]
}

data "azurerm_key_vault" "cfp_demo_kv" {
  name                = azurerm_key_vault.cfp_demo_kv.name
  resource_group_name = azurerm_resource_group.cfp_demo_rg.name
}

data azurerm_key_vault_secret "cfg_demo_PAT" {
  name         = "cfg_demo_pat_ado"
  key_vault_id = data.azurerm_key_vault.cfp_demo_kv.id
}

output "secret_value" {
  value = "${data.azurerm_key_vault_secret.cfg_demo_PAT.value}"
}