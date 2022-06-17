output "ip" {
  value = digitalocean_floating_ip.this.ip_address
}

output "digitalocean_floating_ip" {
  value = digitalocean_floating_ip.this
}

output "digitalocean_droplet" {
  value = digitalocean_droplet.this
}
