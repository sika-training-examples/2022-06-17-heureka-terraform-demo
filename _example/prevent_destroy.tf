resource "null_resource" "prevent_destroy" {
  depends_on = [
    digitalocean_droplet.example,
  ]
  lifecycle {
    prevent_destroy = true
  }
}
