variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
}

variable "environment" {
  type = string
  description = "The environment used for naming convention."
  default = "SDBX"
  
}

variable "storage_account_tier" {
  type = string
  description = "Account tier."
  default = "Standard"
  
}

variable "storage_account_replication_type" {
  type = string
  default = "LRS"
  description = "The replication type of the storage account."
  
}

variable "serviceplan_sku" {
    description = "The SKU of the service plan."
    default = "Y1"
    type = string
}

variable "os_type" {
    description = "The operating system for the function app."
    default = "Windows"
    type = string
}

variable "location" {
  description = "The location of the application insights instance."
  default = "eastus"
  type = string
}

variable "application_name" {
    description = "The application name."
    type = string
}

variable "application_type" {
    description = "Type of application to deploy to application insights."
    default = "dotnet"
    type = string
    validation {
      condition = contains(["dotnet","java","node", "powershell"],var.application_type)
      error_message = "The application_type must contain the following values: [\"dotnet\",\"java\",\"node\",\"powershell\"]"
    }
}

variable "application_stack_version" {
  description = "The version of the app stack (optional)"
  default = "v4.0"
  type = string
}

variable "appinsights_connection_string" {
    description = "Application insights connection string."
    default = null
    type = string
}