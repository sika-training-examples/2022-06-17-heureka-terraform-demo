resource "digitalocean_ssh_key" "default" {
  name       = "ondrejsika"
  public_key = file("./ssh-keys/ondrejsika.pub")
}

resource "digitalocean_ssh_key" "default-ed25519" {
  name       = "ondrejsika"
  public_key = file("./ssh-keys/ondrejsika_ed25519.pub")
}

locals {
  DEFAULT_SSH_KEYS = [
    digitalocean_ssh_key.default.id,
    digitalocean_ssh_key.default-ed25519.id,
  ]
}

resource "digitalocean_droplet" "example" {
  image    = "debian-11-x64"
  name     = "example"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = local.DEFAULT_SSH_KEYS
}

output "ip" {
  value = digitalocean_droplet.example.ipv4_address
}
