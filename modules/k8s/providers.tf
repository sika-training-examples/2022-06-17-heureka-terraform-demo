terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.21.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.17.0"
    }
  }
}
