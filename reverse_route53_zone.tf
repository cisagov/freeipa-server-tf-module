#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "master_private_PTR" {
  zone_id = var.private_reverse_zone_id
  name = format(
    "%s.%s.%s.%s.in-addr.arpa.",
    element(split(".", aws_instance.ipa_master.private_ip), 3),
    element(split(".", aws_instance.ipa_master.private_ip), 2),
    element(split(".", aws_instance.ipa_master.private_ip), 1),
    element(split(".", aws_instance.ipa_master.private_ip), 0),
  )

  type = "PTR"
  ttl  = var.ttl
  records = [
    "ipa.${var.domain}"
  ]
}

resource "aws_route53_record" "replica_private_PTR" {
  count = length(data.aws_subnet.replica_subnets)

  zone_id = var.private_reverse_zone_id
  name = format(
    "%s.%s.%s.%s.in-addr.arpa.",
    element(split(".", aws_instance.ipa_replicas[count.index].private_ip), 3),
    element(split(".", aws_instance.ipa_replicas[count.index].private_ip), 2),
    element(split(".", aws_instance.ipa_replicas[count.index].private_ip), 1),
    element(split(".", aws_instance.ipa_replicas[count.index].private_ip), 0),
  )

  type = "PTR"
  ttl  = var.ttl
  records = [
    format("ipa-replica%d.${var.domain}", count.index + 1)
  ]
}
