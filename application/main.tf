module "vm--db" {
  source             = "../modules/vm"
  name               = "${var.env}-db"
  image              = var.config.image
  cloudflare_zone_id = var.config.zone_id
}

module "vm--redis" {
  source             = "../modules/vm"
  name               = "${var.env}-db"
  image              = var.config.image
  cloudflare_zone_id = var.config.zone_id
}

module "vm--web" {
  source             = "../modules/vm"
  name               = "${var.env}-web"
  image              = var.config.image
  cloudflare_zone_id = var.config.zone_id
  depends_on = [
    module.vm--db,
    module.vm--redis,
  ]
}
