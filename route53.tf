data "aws_route53_zone" "ipa_zone" {
  name = var.zone_name
}

#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "master_A" {
  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "ipa.${data.aws_route53_zone.ipa_zone.name}"
  type    = "A"
  ttl     = 86400
  records = [
    aws_instance.ipa_master.private_ip,
  ]
}

resource "aws_route53_record" "ca_A" {
  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "ipa-ca.${data.aws_route53_zone.ipa_zone.name}"
  type    = "A"
  ttl     = 86400
  records = [
    aws_instance.ipa_master.private_ip,
  ]
}

resource "aws_route53_record" "master_SRV" {
  count = length(local.tcp_and_udp)

  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "_kerberos-master._${local.tcp_and_udp[count.index]}.${data.aws_route53_zone.ipa_zone.name}"
  type    = "SRV"
  ttl     = 86400
  records = [
    "0 100 88 ipa.${data.aws_route53_zone.ipa_zone.name}",
  ]
}

resource "aws_route53_record" "server_SRV" {
  count = length(local.tcp_and_udp)

  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "_kerberos._${local.tcp_and_udp[count.index]}.${data.aws_route53_zone.ipa_zone.name}"
  type    = "SRV"
  ttl     = 86400
  records = [
    "0 100 88 ipa.${data.aws_route53_zone.ipa_zone.name}",
  ]
}

resource "aws_route53_record" "kerberos_TXT" {
  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "_kerberos.${data.aws_route53_zone.ipa_zone.name}"
  type    = "TXT"
  ttl     = 86400
  records = [
    data.aws_route53_zone.ipa_zone.name,
  ]
}

resource "aws_route53_record" "password_SRV" {
  count = length(local.tcp_and_udp)

  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "_kpasswd._${local.tcp_and_udp[count.index]}.${data.aws_route53_zone.ipa_zone.name}"
  type    = "SRV"
  ttl     = 86400
  records = [
    "0 100 464 ipa.${data.aws_route53_zone.ipa_zone.name}",
  ]
}

resource "aws_route53_record" "ldap_SRV" {
  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "_ldap._tcp.${data.aws_route53_zone.ipa_zone.name}"
  type    = "SRV"
  ttl     = 86400
  records = [
    "0 100 389 ipa.${data.aws_route53_zone.ipa_zone.name}",
  ]
}

resource "aws_route53_record" "ntp_SRV" {
  zone_id = data.aws_route53_zone.ipa_zone.zone_id
  name    = "_ntp._udp.${data.aws_route53_zone.ipa_zone.name}"
  type    = "SRV"
  ttl     = 86400
  records = [
    "0 100 123 ipa.${data.aws_route53_zone.ipa_zone.name}",
  ]
}
