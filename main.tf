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

data "digitalocean_droplet_snapshot" "heureka" {
  name_regex  = "^heureka"
  region      = "fra1"
  most_recent = true
}

resource "digitalocean_droplet" "example" {
  image    = data.digitalocean_droplet_snapshot.heureka.id
  name     = "example"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = local.DEFAULT_SSH_KEYS
}

output "ip" {
  value = digitalocean_droplet.example.ipv4_address
}
