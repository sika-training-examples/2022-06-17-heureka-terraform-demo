output "ip" {
  value = digitalocean_loadbalancer.this.ip
}

output "kubeconfig" {
  value = digitalocean_kubernetes_cluster.this.kube_config
}
