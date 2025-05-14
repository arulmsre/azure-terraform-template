terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4.0.0"
    }
    
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "kubectl" {
  host = module.Deploy_AKS_Cluster.host
  cluster_ca_certificate = base64decode(module.Deploy_AKS_Cluster.admin_cluster_ca_certificate)
  username = module.Deploy_AKS_Cluster.username
  password = module.Deploy_AKS_Cluster.password
  client_key = base64decode(module.Deploy_AKS_Cluster.client_key)
  client_certificate = base64decode(module.Deploy_AKS_Cluster.client_certificate)
  load_config_file = false
}

provider "kubernetes" {
  host = module.Deploy_AKS_Cluster.host
  username = module.Deploy_AKS_Cluster.username
  password = module.Deploy_AKS_Cluster.password
  client_key = base64decode(module.Deploy_AKS_Cluster.client_key)
  client_certificate = base64decode(module.Deploy_AKS_Cluster.client_certificate)
  cluster_ca_certificate = base64decode(module.Deploy_AKS_Cluster.admin_cluster_ca_certificate)
  
}

# provider "docker" {
#   host = output.acr_login_server

#   registry_auth {
#     address  = output.acr_login_server
#     username = output.acr_admin_username
#     password = output.acr_admin_password
#   }

# }