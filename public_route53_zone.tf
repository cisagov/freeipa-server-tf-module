#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "public_A" {
  count = var.associate_public_ip_address ? 1 : 0

  zone_id = var.public_zone_id
  name    = var.hostname
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa.public_ip,
  ]
}

resource "aws_route53_record" "ca_public_A" {
  count = (var.associate_public_ip_address ? 1 : 0) * (var.is_master ? 1 : 0)

  zone_id = var.public_zone_id
  name    = "ipa-ca.${var.domain}"
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa.public_ip,
  ]
}

resource "aws_route53_record" "public_SRV" {
  count = (var.associate_public_ip_address ? 1 : 0) * (var.is_master ? 1 : 0) * length(local.tcp_and_udp)

  zone_id = var.public_zone_id
  name    = "_kerberos-master._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ipa.${var.hostname}",
  ]
}

resource "aws_route53_record" "server_public_SRV" {
  count = (var.associate_public_ip_address ? 1 : 0) * (var.is_master ? 1 : 0) * length(local.tcp_and_udp)

  zone_id = var.public_zone_id
  name    = "_kerberos._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ${var.hostname}",
  ]
}

resource "aws_route53_record" "kerberos_public_TXT" {
  count = (var.associate_public_ip_address ? 1 : 0) * (var.is_master ? 1 : 0)

  zone_id = var.public_zone_id
  name    = "_kerberos.${var.domain}"
  type    = "TXT"
  ttl     = var.ttl
  records = [
    upper(var.domain),
  ]
}

resource "aws_route53_record" "password_public_SRV" {
  count = (var.associate_public_ip_address ? 1 : 0) * (var.is_master ? 1 : 0) * length(local.tcp_and_udp)

  zone_id = var.public_zone_id
  name    = "_kpasswd._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 464 ${var.hostname}",
  ]
}

resource "aws_route53_record" "ldap_public_SRV" {
  count = (var.associate_public_ip_address ? 1 : 0) * (var.is_master ? 1 : 0)

  zone_id = var.public_zone_id
  name    = "_ldap._tcp.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 389 ${var.hostname}",
  ]
}
