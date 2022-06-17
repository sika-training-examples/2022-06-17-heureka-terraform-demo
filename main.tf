locals {
  ZONE_ID_SIKADEMO_COM = "f2c00168a7ecd694bb1ba017b332c019"
  DEBIAN               = "debian-11-x64"
}

module "vm--foo" {
  source             = "./modules/vm"
  name               = "foo"
  image              = local.DEBIAN
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM
}

module "vm--bar" {
  source             = "./modules/vm"
  name               = "bar"
  image              = local.DEBIAN
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM

}

output "ip-foo" {
  value = module.vm--foo.ip
}

output "ip-bar" {
  value = module.vm--bar.ip
}

module "k8s--dev" {
  source             = "./modules/k8s"
  name               = "dev"
  node_count         = 2
  cloudflare_zone_id = local.ZONE_ID_SIKADEMO_COM
}
