# Security group for IPA servers
resource "aws_security_group" "ipa_servers" {
  vpc_id = data.aws_subnet.master_subnet.vpc_id

  description = "Security group for IPA servers"
  tags        = var.tags
}

# TCP ingress rules for IPA
resource "aws_security_group_rule" "ipa_tcp_ingress" {
  count = length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = var.trusted_cidr_blocks
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}

# UDP ingress rules for IPA
resource "aws_security_group_rule" "ipa_udp_ingress" {
  count = length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "ingress"
  protocol          = "udp"
  cidr_blocks       = var.trusted_cidr_blocks
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}
