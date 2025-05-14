resource "azurerm_mssql_server" "deploy_sqlserver" {
  name                         = "${lower(var.application_name)}-${lower(var.location)}-sqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version = "12.0"
  administrator_login_password = "p@$$word1"
  administrator_login = "us3rn@me!"
}

resource "azurerm_mssql_database" "deploy_sqldatabase" {
  name           = "${lower(var.application_name)}-${lower(var.location)}-sqldb"
  server_id      = azurerm_mssql_server.deploy_sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}