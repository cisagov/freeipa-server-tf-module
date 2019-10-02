# Security group for IPA clients
resource "aws_security_group" "ipa_clients" {
  vpc_id = data.aws_subnet.the_subnet.vpc_id

  description = "Security group for IPA clients"
  tags        = var.tags
}

# TCP egress rules for IPA
resource "aws_security_group_rule" "ipa_client_tcp_egress" {
  count = length(local.ipa_tcp_ports)

  security_group_id        = aws_security_group.ipa_clients.id
  type                     = "egress"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ipa_servers.id
  from_port                = local.ipa_tcp_ports[count.index]
  to_port                  = local.ipa_tcp_ports[count.index]
}

# UDP egress rules for IPA
resource "aws_security_group_rule" "ipa_client_udp_egress" {
  count = length(local.ipa_udp_ports)

  security_group_id        = aws_security_group.ipa_clients.id
  type                     = "egress"
  protocol                 = "udp"
  source_security_group_id = aws_security_group.ipa_servers.id
  from_port                = local.ipa_udp_ports[count.index]
  to_port                  = local.ipa_udp_ports[count.index]
}
