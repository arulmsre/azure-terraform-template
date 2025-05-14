output "admin_cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kube_config[0].cluster_ca_certificate
    sensitive = true
}
output "host" {
    value =  azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kube_config[0].host
}

output "username" {
    value =  azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kube_config[0].username
}

output "password" {
    value =  azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kube_config[0].password
    sensitive = true
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
    value = azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kube_config[0].client_key
    sensitive = true
}

output "kubelet_object_id" {
  value = azurerm_kubernetes_cluster.deploy_kubernetes_cluster.kubelet_identity[0].object_id
}
