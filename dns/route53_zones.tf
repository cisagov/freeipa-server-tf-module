#-------------------------------------------------------------------------------
# Configure the Route53 zone modules
#-------------------------------------------------------------------------------
module "private_zone" {
  source = "./route53_zone"

  providers = {
    aws = aws
  }

  domain   = var.domain
  hostname = var.hostname
  ip       = var.ip
  zone_id  = var.zone_id
  ttl      = var.ttl
}
