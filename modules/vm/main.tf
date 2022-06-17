resource "digitalocean_floating_ip" "this" {
  region = var.region
}

resource "digitalocean_droplet" "this" {
  image    = var.image
  name     = var.name
  region   = var.region
  size     = var.size
  ssh_keys = var.ssh_keys
}

resource "digitalocean_floating_ip_assignment" "this" {
  ip_address = digitalocean_floating_ip.this.ip_address
  droplet_id = digitalocean_droplet.this.id
}

resource "cloudflare_record" "A" {
  zone_id = var.cloudflare_zone_id
  name    = var.name
  value   = digitalocean_floating_ip.this.ip_address
  type    = "A"
}

resource "cloudflare_record" "wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*.${var.name}"
  value   = cloudflare_record.A.hostname
  type    = "CNAME"
}
