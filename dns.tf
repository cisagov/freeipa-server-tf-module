#-------------------------------------------------------------------------------
# Configure the DNS module
#-------------------------------------------------------------------------------
module "dns" {
  source = "./dns"

  domain          = var.domain
  hostname        = var.hostname
  ip              = aws_instance.ipa.private_ip
  reverse_zone_id = var.reverse_zone_id
  tags            = var.tags
  ttl             = var.ttl
  zone_id         = var.zone_id
}
