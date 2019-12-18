#-------------------------------------------------------------------------------
# Configure the DNS module
#-------------------------------------------------------------------------------
module "dns" {
  source = "./dns"

  providers = {
    aws            = aws
    aws.public_dns = aws.public_dns
  }

  associate_public_ip_address = var.associate_public_ip_address
  domain                      = var.domain
  hostname                    = var.hostname
  private_ip                  = aws_instance.ipa.private_ip
  private_reverse_zone_id     = var.private_reverse_zone_id
  private_zone_id             = var.private_zone_id
  public_ip                   = aws_instance.ipa.public_ip
  public_zone_id              = var.public_zone_id
  tags                        = var.tags
  ttl                         = var.ttl
}
