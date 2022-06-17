output "ip" {
  value = digitalocean_droplet.this.ipv4_address
}

output "digitalocean_droplet" {
  value = digitalocean_droplet.this
}
