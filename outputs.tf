output "client_security_group" {
  value       = aws_security_group.ipa_clients
  description = "The IPA client security group."
}

output "master" {
  value       = aws_instance.ipa
  description = "The IPA master EC2 instance."
}

output "server_security_group" {
  value       = aws_security_group.ipa_servers
  description = "The IPA server security group."
}
