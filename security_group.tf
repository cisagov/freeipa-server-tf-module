# Security group for IPA servers
resource "aws_security_group" "ipa_servers" {
  count = var.is_master ? 1 : 0

  vpc_id = data.aws_subnet.the_subnet.vpc_id

  description = "Security group for IPA servers"
  tags        = var.tags
}

# TCP ingress rules for IPA
resource "aws_security_group_rule" "ipa_tcp_ingress_trusted" {
  count = (var.is_master ? 1 : 0) * length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers[0].id
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = var.trusted_cidr_blocks
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}
resource "aws_security_group_rule" "ipa_tcp_ingress_self" {
  count = (var.is_master ? 1 : 0) * length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers[0].id
  type              = "ingress"
  protocol          = "tcp"
  self              = true
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}

# TCP egress rules for IPA
resource "aws_security_group_rule" "ipa_tcp_egress" {
  count = (var.is_master ? 1 : 0) * length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers[0].id
  type              = "egress"
  protocol          = "tcp"
  self              = true
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}

# UDP ingress rules for IPA
resource "aws_security_group_rule" "ipa_udp_ingress_trusted" {
  count = (var.is_master ? 1 : 0) * length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers[0].id
  type              = "ingress"
  protocol          = "udp"
  cidr_blocks       = var.trusted_cidr_blocks
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}
resource "aws_security_group_rule" "ipa_udp_ingress_self" {
  count = (var.is_master ? 1 : 0) * length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers[0].id
  type              = "ingress"
  protocol          = "udp"
  self              = true
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}

# UDP egress rules for IPA
resource "aws_security_group_rule" "ipa_udp_egress" {
  count = (var.is_master ? 1 : 0) * length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers[0].id
  type              = "egress"
  protocol          = "udp"
  self              = true
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}
