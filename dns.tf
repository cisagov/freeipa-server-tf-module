#-------------------------------------------------------------------------------
# Create A and PTR records for the IPA server
#-------------------------------------------------------------------------------
resource "aws_route53_record" "server_A" {
  zone_id = var.zone_id
  name    = var.hostname
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa.private_ip,
  ]
}

resource "aws_route53_record" "ptr" {
  zone_id = var.reverse_zone_id
  name = format(
    "%s.%s.%s.%s.in-addr.arpa.",
    element(split(".", aws_instance.ipa.private_ip), 3),
    element(split(".", aws_instance.ipa.private_ip), 2),
    element(split(".", aws_instance.ipa.private_ip), 1),
    element(split(".", aws_instance.ipa.private_ip), 0),
  )

  type = "PTR"
  ttl  = var.ttl
  records = [
    var.hostname
  ]
}
