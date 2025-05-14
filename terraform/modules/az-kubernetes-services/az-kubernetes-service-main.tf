resource "azurerm_kubernetes_cluster" "deploy_kubernetes_cluster" {
    name = "${upper(var.application_name)}-${upper(var.location)}-AKS"
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = "${upper(var.application_name)}-${upper(var.location)}-DNS"
    default_node_pool {
      name = "default"
      node_count = var.aks_node_count
      vm_size = var.aks_vm_size
      enable_auto_scaling = var.aks_enable_autoscaling
    }
    identity {
      type = var.aks_identity_type
    }
    oms_agent {
      log_analytics_workspace_id = var.workspace_id
  }
}

# resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "aks_rbac_access" {
#   kubernetes_cluster_id = deploy_kubernetes_cluster.id
#   name                  = "${upper(var.application_name)}-${upper(var.location)}-AKS-RBAC"
#   roles                 = "example-value"
#   source_resource_id    = deploy_kubernetes_cluster.id
# }


# resource "kubernetes_namespace" "az_aks_namespace" {
#   depends_on = [ deploy_kubernetes_cluster ]

# }