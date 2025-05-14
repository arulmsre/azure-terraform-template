terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "511235a9-1907-41f1-b32f-27948e2a86be"
}