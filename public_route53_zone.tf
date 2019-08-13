#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "master_public_A" {
  zone_id = var.public_zone_id
  name    = "ipa.${var.domain}"
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa_master.public_ip,
  ]
}

resource "aws_route53_record" "replica_public_A" {
  count = length(data.aws_subnet.replica_subnets)

  zone_id = var.public_zone_id
  name    = format("ipa-replica%d.${var.domain}", count.index + 1)
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa_replicas[count.index].public_ip,
  ]
}

resource "aws_route53_record" "ca_public_A" {
  zone_id = var.public_zone_id
  name    = "ipa-ca.${var.domain}"
  type    = "A"
  ttl     = var.ttl
  records = [
    aws_instance.ipa_master.public_ip,
  ]
}

resource "aws_route53_record" "master_public_SRV" {
  count = length(local.tcp_and_udp)

  zone_id = var.public_zone_id
  name    = "_kerberos-master._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ipa.${var.domain}",
  ]
}

resource "aws_route53_record" "server_public_SRV" {
  count = length(local.tcp_and_udp)

  zone_id = var.public_zone_id
  name    = "_kerberos._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 88 ipa.${var.domain}",
  ]
}

resource "aws_route53_record" "kerberos_public_TXT" {
  zone_id = var.public_zone_id
  name    = "_kerberos.${var.domain}"
  type    = "TXT"
  ttl     = var.ttl
  records = [
    upper(var.domain),
  ]
}

resource "aws_route53_record" "password_public_SRV" {
  count = length(local.tcp_and_udp)

  zone_id = var.public_zone_id
  name    = "_kpasswd._${local.tcp_and_udp[count.index]}.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 464 ipa.${var.domain}",
  ]
}

resource "aws_route53_record" "ldap_public_SRV" {
  zone_id = var.public_zone_id
  name    = "_ldap._tcp.${var.domain}"
  type    = "SRV"
  ttl     = var.ttl
  records = [
    "0 100 389 ipa.${var.domain}",
  ]
}
