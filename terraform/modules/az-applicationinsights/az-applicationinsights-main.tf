resource "azurerm_application_insights" "deploy_appinsights" {
  name                = var.useGeneric ? "CAPGEMINI-SRE-DEMO-APPINSIGHT" : "${upper(var.application_name)}-${upper(var.location)}-APPLICATIONINSIGHTS"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
}