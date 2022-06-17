locals {
  ZONE_ID_SIKADEMO_COM = "f2c00168a7ecd694bb1ba017b332c019"
  DEBIAN               = "debian-11-x64"
  DEBIAN10             = "debian-10-x64"
}

module "dev" {
  source = "./application"
  env    = "dev"
  config = {
    image   = local.DEBIAN
    zone_id = local.ZONE_ID_SIKADEMO_COM
  }
}

module "prod" {
  source = "./application"
  env    = "prod"
  config = {
    image   = local.DEBIAN10
    zone_id = local.ZONE_ID_SIKADEMO_COM
  }
}
