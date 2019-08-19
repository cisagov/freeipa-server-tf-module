output "id" {
  value       = aws_instance.ipa.id
  description = "The EC2 instance ID corresponding to the IPA master"
}

output "server_security_group_id" {
  value       = aws_security_group.ipa_servers.id
  description = "The ID of the IPA server security group"
}
