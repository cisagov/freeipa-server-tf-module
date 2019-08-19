#-------------------------------------------------------------------------------
# Configure the Route53 zone modules
#-------------------------------------------------------------------------------
module "private_zone" {
  source = "./route53_zone"

  domain    = var.domain
  hostname  = var.hostname
  ip        = var.private_ip
  is_master = var.is_master
  zone_id   = var.private_zone_id
  ttl       = var.ttl
}

module "public_zone" {
  source = "./route53_zone"

  do_it     = var.associate_public_ip_address
  domain    = var.domain
  hostname  = var.hostname
  ip        = var.public_ip
  is_master = var.is_master
  zone_id   = var.public_zone_id
  ttl       = var.ttl
}
