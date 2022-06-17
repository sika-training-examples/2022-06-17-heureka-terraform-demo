resource "digitalocean_ssh_key" "default" {
  name       = "ondrejsika"
  public_key = file("./ssh-keys/ondrejsika.pub")
}

resource "digitalocean_ssh_key" "default-ed25519" {
  name       = "ondrejsika"
  public_key = file("./ssh-keys/ondrejsika_ed25519.pub")
}

resource "digitalocean_ssh_key" "ipad" {
  name       = "ipad"
  public_key = file("./ssh-keys/ipad.pub")
}

locals {
  DEFAULT_SSH_KEYS = [
    digitalocean_ssh_key.default.id,
    digitalocean_ssh_key.default-ed25519.id,
    digitalocean_ssh_key.ipad.id,
  ]
}

data "digitalocean_droplet_snapshot" "heureka" {
  name_regex  = "^heureka"
  region      = "fra1"
  most_recent = true
}

resource "digitalocean_droplet" "example" {
  count = 2

  image    = data.digitalocean_droplet_snapshot.heureka.id
  name     = "example${count.index}"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = local.DEFAULT_SSH_KEYS

  lifecycle {
    ignore_changes = [
      ssh_keys,
    ]
  }
}

output "ip" {
  value = digitalocean_droplet.example[*].ipv4_address
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}
