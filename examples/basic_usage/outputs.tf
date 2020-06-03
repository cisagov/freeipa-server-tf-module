output "ipa_client_security_group" {
  value       = module.ipa.client_security_group
  description = "The IPA client security group."
}

output "ipa_server_security_group" {
  value       = module.ipa.server_security_group
  description = "The IPA server security group."
}

output "ipa_server" {
  value       = module.ipa
  description = "The IPA server EC2 instance."
}
