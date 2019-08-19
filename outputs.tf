output "id" {
  value       = aws_instance.ipa.id
  description = "The EC2 instance ID corresponding to the IPA server"
}

output "server_security_group_id" {
  value       = local.server_security_group_id
  description = "The ID of the IPA server security group"
}
