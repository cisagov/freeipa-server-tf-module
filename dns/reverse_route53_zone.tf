#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "private_PTR" {
  zone_id = var.private_reverse_zone_id
  name = format(
    "%s.%s.%s.%s.in-addr.arpa.",
    element(split(".", var.private_ip), 3),
    element(split(".", var.private_ip), 2),
    element(split(".", var.private_ip), 1),
    element(split(".", var.private_ip), 0),
  )

  type = "PTR"
  ttl  = var.ttl
  records = [
    "${var.hostname}"
  ]
}
