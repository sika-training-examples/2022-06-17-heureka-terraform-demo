locals {
  ZONE_ID_SIKADEMO_COM = "f2c00168a7ecd694bb1ba017b332c019"
  DEBIAN10             = "debian-10-x64"
}

module "prod" {
  source = "../../application"
  env    = "prod"
  config = {
    image   = local.DEBIAN10
    zone_id = local.ZONE_ID_SIKADEMO_COM
  }
}
