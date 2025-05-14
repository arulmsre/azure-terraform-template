variable "resource_group_name" {
  description = "The name of the resource group."
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
    default = "web"
    type = string
    validation {
      condition = contains(["web","java","ios","MobileCenter","Node.JS","other","phone","store"],var.application_type)
      error_message = "The application_type must contain the following values: [\"web\",\"java\",\"ios\",\"MobileCenter\",\"Node.JS\",\"other\",\"phone\",\"store\"]"
    }
  
}

variable "aks_enable_autoscaling" {
  type = bool
  default = false
  description = "Enable autoscaling on AKS."
}

variable "aks_vm_size" {
  type = string
  default = "Standard_D4ds_v5"
  description = "AKS VM count."
}

variable "aks_node_count" {
  type = number
  default = 1
  description = "AKS Node count."
}


variable "aks_identity_type" {
  type = string
  default = "SystemAssigned"
  description = "Identity management for AKS."
    validation {
      condition = contains(["UserAssigned", "SystemAssigned"],var.aks_identity_type)
      error_message = "The application_type must contain the following values: [\"SystemAssigned\",\"UserAssgned\"]"
    }
}

variable "workspace_id" {
  default = null
  type = string
}