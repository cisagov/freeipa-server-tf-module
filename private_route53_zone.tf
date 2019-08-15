#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "private_A" {
  zone_id = var.private_zone_id
  name    = var.hostname
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa.private_ip,
  ]
}

resource "aws_route53_record" "ca_private_A" {
  count = var.is_master ? 1 : 0

  zone_id = var.private_zone_id
  name    = "ipa-ca.${var.domain}"
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa.private_ip,
  ]
}

resource "aws_route53_record" "private_SRV" {
  count = (var.is_master ? 1 : 0) * length(local.tcp_and_udp)

  zone_id = var.private_zone_id
  name    = "_kerberos-master._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ${var.hostname}",
  ]
}

resource "aws_route53_record" "server_private_SRV" {
  count = (var.is_master ? 1 : 0) * length(local.tcp_and_udp)

  zone_id = var.private_zone_id
  name    = "_kerberos._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ${var.hostname}",
  ]
}

resource "aws_route53_record" "kerberos_private_TXT" {
  count = var.is_master ? 1 : 0

  zone_id = var.private_zone_id
  name    = "_kerberos.${var.domain}"
  type    = "TXT"
  ttl     = var.ttl
  records = [
    upper(var.domain),
  ]
}

resource "aws_route53_record" "password_private_SRV" {
  count = (var.is_master ? 1 : 0) * length(local.tcp_and_udp)

  zone_id = var.private_zone_id
  name    = "_kpasswd._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 464 ${var.hostname}",
  ]
}

resource "aws_route53_record" "ldap_private_SRV" {
  count = var.is_master ? 1 : 0

  zone_id = var.private_zone_id
  name    = "_ldap._tcp.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 389 ${var.hostname}",
  ]
}
