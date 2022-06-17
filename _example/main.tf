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
  DEBIAN = "debian-11-x64"
}

data "digitalocean_droplet_snapshot" "heureka" {
  name_regex  = "^heureka"
  region      = "fra1"
  most_recent = true
}

locals {
  droplets = {
    foo = data.digitalocean_droplet_snapshot.heureka.id
  }
}

resource "digitalocean_droplet" "example" {
  for_each = local.droplets

  image    = each.value
  name     = each.key
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = local.DEFAULT_SSH_KEYS

  lifecycle {
    ignore_changes = [
      ssh_keys,
    ]
    prevent_destroy = true
  }
  provisioner "local-exec" {
    command = "slu wf tcp -a ${self.ipv4_address}:80 -t 15"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "echo backup droplet ${self.id}"
  }
}

output "ip-list" {
  value = [
    for key, vm in digitalocean_droplet.example :
    vm.ipv4_address
  ]
}

output "ip" {
  value = {
    for key, vm in digitalocean_droplet.example :
    key => vm.ipv4_address
  }
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
