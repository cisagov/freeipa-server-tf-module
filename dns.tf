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

resource "aws_route53_record" "ca_A" {
  zone_id = var.zone_id
  name    = "ipa-ca.${var.domain}"
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa.private_ip,
  ]
}

resource "aws_route53_record" "kerberos_TXT" {
  zone_id = var.zone_id
  name    = "_kerberos.${var.domain}"
  type    = "TXT"
  ttl     = var.ttl
  records = [
    upper(var.domain),
  ]
}

resource "aws_route53_record" "SRV" {
  for_each = local.tcp_and_udp

  zone_id = var.zone_id
  name    = "_kerberos-master._${each.value}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ${var.hostname}",
  ]
}

resource "aws_route53_record" "server_SRV" {
  for_each = local.tcp_and_udp

  zone_id = var.zone_id
  name    = "_kerberos._${each.value}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ${var.hostname}",
  ]
}

resource "aws_route53_record" "password_SRV" {
  for_each = local.tcp_and_udp

  zone_id = var.zone_id
  name    = "_kpasswd._${each.value}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 464 ${var.hostname}",
  ]
}

resource "aws_route53_record" "ldap_SRV" {
  zone_id = var.zone_id
  name    = "_ldap._tcp.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 389 ${var.hostname}",
  ]
}

resource "aws_route53_record" "ldaps_SRV" {
  zone_id = var.zone_id
  name    = "_ldaps._tcp.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 636 ${var.hostname}",
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
