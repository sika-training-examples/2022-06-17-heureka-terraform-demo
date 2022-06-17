locals {
  ZONE_ID_SIKADEMO_COM = "f2c00168a7ecd694bb1ba017b332c019"
  DEBIAN               = "debian-11-x64"
}

module "vm--dev-db" {
  source             = "./modules/vm"
  name               = "dev-db"
  image              = local.DEBIAN
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM
}

module "vm--dev-web" {
  source             = "./modules/vm"
  name               = "dev-web"
  image              = local.DEBIAN
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM
  depends_on = [
    module.vm--dev-db,
  ]
}

module "vm--prod-db" {
  source             = "./modules/vm"
  name               = "prod-db"
  image              = local.DEBIAN
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM
}

module "vm--prod-web" {
  source             = "./modules/vm"
  name               = "prod-web"
  image              = local.DEBIAN
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM
  depends_on = [
    module.vm--prod-db,
  ]
}
