resource "azurerm_container_registry" "az_acr" {
    name = "CAPGEMINISRE${upper(var.location)}ACR"
    resource_group_name = var.resource_group_name
    sku = var.sku
    location = var.location
    admin_enabled = true
}