resource "digitalocean_kubernetes_cluster" "this" {
  name    = var.name
  region  = var.region
  version = "1.22.8-do.1"

  node_pool {
    name       = var.name
    size       = var.size
    node_count = var.node_count
  }
}

resource "digitalocean_loadbalancer" "this" {
  name        = var.name
  region      = var.region
  droplet_tag = "k8s:${digitalocean_kubernetes_cluster.this.id}"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "tcp"

    target_port     = 80
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "tcp"

    target_port     = 443
    target_protocol = "tcp"
  }

  healthcheck {
    port     = 80
    protocol = "tcp"
  }
}

resource "cloudflare_record" "A" {
  zone_id = var.cloudflare_zone_id
  name    = var.name
  value   = digitalocean_loadbalancer.this.ip
  type    = "A"
}

resource "cloudflare_record" "wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*.${var.name}"
  value   = cloudflare_record.A.hostname
  type    = "CNAME"
}
