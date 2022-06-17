variable "name" {
  type        = string
  description = "Name of VM"
}

variable "image" {
  type = string
}

variable "region" {
  type    = string
  default = "fra1"
}

variable "size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "cloudflare_zone_id" {
  type = string
}
