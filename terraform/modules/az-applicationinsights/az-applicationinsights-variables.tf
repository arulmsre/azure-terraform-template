variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
}

variable "useGeneric" {
  description = "Use a generic name for application insights or a name based on application"
  type = bool
  default = false
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
    default = "web"
    type = string
    validation {
      condition = contains(["web","java","ios","MobileCenter","Node.JS","other","phone","store"],var.application_type)
      error_message = "The application_type must contain the following values: [\"web\",\"java\",\"ios\",\"MobileCenter\",\"Node.JS\",\"other\",\"phone\",\"store\"]"
    }
  
}

variable "workspace_id" {
    description = "Type of application to deploy to application insights."
    default = null
    type = string
}