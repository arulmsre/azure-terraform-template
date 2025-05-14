# Variables needed for the pet clinic application
variable "application_name" {
  default = "spring-petclinic-microservices"
  type = string
}

variable "location" {
  default = "eastus"
  type = string
}

variable "resource_group" {
    default = "fs-sreassets-demo-rg"
    type = string
}
