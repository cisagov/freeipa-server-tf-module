# Security group for IPA servers
resource "aws_security_group" "ipa_servers" {
  vpc_id = data.aws_subnet.the_subnet.vpc_id

  description = "Security group for IPA servers"
  tags        = var.tags
}

# Allow HTTPS out anywhere.  This is needed to retrieve certificates
# from S3.
resource "aws_security_group_rule" "ipa_server_https_egress" {
  security_group_id = aws_security_group.ipa_servers.id
  type              = "egress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
}

# TCP ingress rules for IPA
resource "aws_security_group_rule" "ipa_server_tcp_ingress_trusted" {
  count = length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = var.trusted_cidr_blocks
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}
resource "aws_security_group_rule" "ipa_server_tcp_ingress_self" {
  count = length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "ingress"
  protocol          = "tcp"
  self              = true
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}
resource "aws_security_group_rule" "ipa_server_tcp_ingress_clients" {
  count = length(local.ipa_tcp_ports)

  security_group_id        = aws_security_group.ipa_servers.id
  type                     = "ingress"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ipa_clients.id
  from_port                = local.ipa_tcp_ports[count.index]
  to_port                  = local.ipa_tcp_ports[count.index]
}

# TCP egress rules for IPA
resource "aws_security_group_rule" "ipa_server_tcp_egress_self" {
  count = length(local.ipa_tcp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "egress"
  protocol          = "tcp"
  self              = true
  from_port         = local.ipa_tcp_ports[count.index]
  to_port           = local.ipa_tcp_ports[count.index]
}

# UDP ingress rules for IPA
resource "aws_security_group_rule" "ipa_server_udp_ingress_trusted" {
  count = length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "ingress"
  protocol          = "udp"
  cidr_blocks       = var.trusted_cidr_blocks
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}
resource "aws_security_group_rule" "ipa_server_udp_ingress_self" {
  count = length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "ingress"
  protocol          = "udp"
  self              = true
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}
resource "aws_security_group_rule" "ipa_server_udp_ingress_clients" {
  count = length(local.ipa_udp_ports)

  security_group_id        = aws_security_group.ipa_servers.id
  type                     = "ingress"
  protocol                 = "udp"
  source_security_group_id = aws_security_group.ipa_clients.id
  from_port                = local.ipa_udp_ports[count.index]
  to_port                  = local.ipa_udp_ports[count.index]
}

# UDP egress rules for IPA
resource "aws_security_group_rule" "ipa_server_udp_egress_self" {
  count = length(local.ipa_udp_ports)

  security_group_id = aws_security_group.ipa_servers.id
  type              = "egress"
  protocol          = "udp"
  self              = true
  from_port         = local.ipa_udp_ports[count.index]
  to_port           = local.ipa_udp_ports[count.index]
}
