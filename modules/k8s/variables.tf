variable "name" {
  type = string
}

variable "node_count" {
  type = number
}

variable "region" {
  type    = string
  default = "fra1"
}

variable "size" {
  type    = string
  default = "s-2vcpu-2gb"
}

variable "cloudflare_zone_id" {
  type = string
}
