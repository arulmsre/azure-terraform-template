# Deploy all necessary resources for the pet clinic application to Azure.
module "Deploy_LogAnalytics_Workspace" {
    source = "../../modules/az-log-analytics-workspace"
    application_name = var.application_name
    location = var.location
    resource_group = var.resource_group
}

# module "Deploy_ACR" {
#     source = "../../modules/az-container-registry"
#     # application_name = var.application_name
#     # resource_group_name = var.resource_group
#     # location = var.location
# }


module "Deploy_Application_Insights_Instance" {
    source = "../../modules/az-applicationinsights"
    application_name = var.application_name
    location = var.location
    resource_group_name = var.resource_group
}

# module "Deploy_AZSQL_Database" {
#     source = "../../modules/az-sql-database"   
#     application_name = var.application_name
#     location = var.location
#     resource_group_name = var.resource_group
# }

module "Deploy_Function_App" {
    source = "../../modules/az-functionapp"   
    application_name = var.application_name
    location = var.location
    resource_group_name = var.resource_group
    appinsights_connection_string = module.Deploy_Application_Insights_Instance.connection_string
    depends_on = [ module.Deploy_Application_Insights_Instance ]
}

module "Deploy_AKS_Cluster" {
    source = "../../modules/az-kubernetes-services"
    application_name = var.application_name
    location = var.location
    resource_group_name = var.resource_group
    workspace_id = module.Deploy_LogAnalytics_Workspace.law_workspace_id
    depends_on = [ module.Deploy_LogAnalytics_Workspace ]
}

data "terraform_remote_state" "acr_configuration" {
  backend = "local"
  config = {
    path = "../../modules/az-container-registry/terraform.tfstate"
  }
}

resource "kubernetes_secret" "create_acr_secret" {
  metadata {
    name = "myregistrykey"
  }

  type = "kubernetes.io/dockerconfigjson"

  binary_data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${data.terraform_remote_state.acr_configuration.outputs.acr_login_server}" = {
          "username" = "${data.terraform_remote_state.acr_configuration.outputs.acr_admin_username}"
          "password" = "${data.terraform_remote_state.acr_configuration.outputs.acr_admin_password}"
          "email"    = ""
        }
      }
    }))
  }
  depends_on = [ module.Deploy_AKS_Cluster, data.terraform_remote_state.acr_configuration ]
}


# resource "azurerm_public_ip" "petclinic_static_ip" {
#   name                = "capgemini-${lower(var.application_name)}-public-ip"
#   resource_group_name = var.resource_group
#   location            = var.location
#   allocation_method   = "Static"
# }


resource "kubernetes_config_map" "petclinic_config_map" {
  metadata {
    name = "petclinic-configmap"
  }

  data = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = "${module.Deploy_Application_Insights_Instance.connection_string}"
  }

  depends_on = [
        module.Deploy_AKS_Cluster
  ]
}


resource "kubectl_manifest" "deploy_petclinic_aks" {
    for_each = fileset("${path.cwd}", "/aks-deployment/*.yaml")
    yaml_body = file(each.value)
    depends_on = [
    module.Deploy_AKS_Cluster, resource.kubernetes_secret.create_acr_secret, resource.kubernetes_config_map.petclinic_config_map
  ]
}