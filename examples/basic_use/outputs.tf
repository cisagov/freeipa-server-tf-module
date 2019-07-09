output "master_id" {
  value       = module.ipa.master_id
  description = "The EC2 instance ID corresponding to the IPA master"
}

output "master_arn" {
  value       = module.ipa.master_arn
  description = "The EC2 instance ARN corresponding to the IPA master"
}

output "master_availability_zone" {
  value       = module.ipa.master_availability_zone
  description = "The AZ where the IPA master instance is deployed"
}

output "master_private_ip" {
  value       = module.ipa.master_private_ip
  description = "The private IP of the IPA master instance"
}

output "master_public_ip" {
  value       = module.ipa.master_public_ip
  description = "The public IP of the IPA master instance"
}

output "master_subnet_id" {
  value       = module.ipa.master_subnet_id
  description = "The ID of the subnet where the IPA master instance is deployed"
}

output "master_security_group_id" {
  value       = module.ipa.master_security_group_id
  description = "The ID of the IPA server security group"
}

output "master_security_group_arn" {
  value       = module.ipa.master_security_group_arn
  description = "The ARN of the IPA server security group"
}
