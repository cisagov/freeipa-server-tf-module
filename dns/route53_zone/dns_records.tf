#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "A" {
  zone_id = var.zone_id
  name    = var.hostname
  type    = "A"
  ttl     = var.ttl
  records = [
    var.ip,
  ]
}
