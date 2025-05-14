output "connection_string" {
  value = azurerm_application_insights.deploy_appinsights.connection_string
}

output "workspace_id" {
  value = azurerm_application_insights.deploy_appinsights.workspace_id
}