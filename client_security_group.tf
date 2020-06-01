# Security group for IPA clients
resource "aws_security_group" "ipa_clients" {
  vpc_id = data.aws_subnet.the_subnet.vpc_id

  description = "Security group for IPA clients"
  tags        = var.tags
}

# Egress rules for IPA
resource "aws_security_group_rule" "ipa_client_egress" {
  for_each = local.ipa_ports

  security_group_id        = aws_security_group.ipa_clients.id
  type                     = "egress"
  protocol                 = each.value.proto
  source_security_group_id = aws_security_group.ipa_servers.id
  from_port                = each.value.port
  to_port                  = each.value.port
}
