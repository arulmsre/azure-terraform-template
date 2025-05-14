output "acr_name" {
  value = azurerm_container_registry.az_acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.az_acr.login_server
}

output "acr_admin_username" {
  value = azurerm_container_registry.az_acr.admin_username
}

output "acr_admin_password" {
  value = azurerm_container_registry.az_acr.admin_password
  sensitive = true
}

output "acr_id" {
  value = azurerm_container_registry.az_acr.id
}