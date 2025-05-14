variable "application_name" {
  type = string
}

variable "location" {
  default = "eastus"
  type = string
}

variable "resource_group" {
    type = string
}

variable "sku" {
  default = "PerGB2018"
  type = string
}

variable "data_retention_days" {
  default = 30
  type = number
}