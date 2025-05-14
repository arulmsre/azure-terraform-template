resource "azurerm_storage_account" "deploy_functionapp_storageacct" {
  name                     = "${substr(lower(replace(var.application_name,"/[^a-zA-Z]+/", "")),0,23)}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_service_plan" "deploy_functionapp_serviceplan" {
  name                = "${substr(lower(replace(var.application_name,"/[^a-zA-Z]+/", "")),0,23)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.serviceplan_sku
}


resource "azurerm_windows_function_app" "deploy_functionapp" {
  count = var.os_type == "Windows" ? 1 : 0
  name                       = "CAP-SRE-${upper(var.environment)}-${upper(var.application_name)}-FUNCTIONAPP"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  storage_account_name       = azurerm_storage_account.deploy_functionapp_storageacct.name
  storage_account_access_key = azurerm_storage_account.deploy_functionapp_storageacct.primary_access_key
  service_plan_id            = azurerm_service_plan.deploy_functionapp_serviceplan.id

  site_config {
      application_insights_connection_string = var.appinsights_connection_string
      dynamic "application_stack" {
        for_each = (var.application_type == "dotnet" && contains(["v3.0", "v4.0","v6.0", "v7.0", "v8.0"],var.application_stack_version)) ? [1] : []
        content {
          dotnet_version = var.application_stack_version
        }
      }
      dynamic "application_stack" {
        for_each = (var.application_type == "java" && contains(["1.8", "11","17"],var.application_stack_version)) ? [1] : []
        content {
          java_version = var.application_stack_version
        }
      }

      dynamic "application_stack" {
        for_each = (var.application_type == "powershell" && contains(["7", "7.2","7.4"],var.application_stack_version)) ? [1] : []
        content {
          powershell_core_version = var.application_stack_version
        }
      }

      dynamic "application_stack" {
        for_each = (var.application_type == "node" && contains(["~12", "~14","~16", "~18", "~20"],var.application_stack_version)) ? [1] : []
        content {
          node_version = var.application_stack_version
        }
      }
  }

}