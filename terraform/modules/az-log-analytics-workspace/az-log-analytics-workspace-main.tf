resource "azurerm_log_analytics_workspace" "az_law" {
  name                = "${replace(lower(var.application_name),"_","-")}-${lower(var.location)}-law"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.sku
  retention_in_days   = var.data_retention_days
}