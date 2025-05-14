variable "resource_group_name" {
  description = "The name of the resource group."
  default = "fs-sreassets-demo-rg"
  type = string
}

variable "location" {
  description = "The location of the application insights instance."
  default = "eastus"
  type = string
}

variable "sku" {
  description = "The SKU name of the container registry."
  default = "Basic"
  type = string
}