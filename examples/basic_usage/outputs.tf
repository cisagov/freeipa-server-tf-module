output "id" {
  value       = module.ipa.id
  description = "The EC2 instance ID corresponding to the IPA master"
}

output "arn" {
  value       = module.ipa.arn
  description = "The EC2 instance ARN corresponding to the IPA master"
}

output "availability_zone" {
  value       = module.ipa.availability_zone
  description = "The AZ where the IPA master instance is deployed"
}

output "private_ip" {
  value       = module.ipa.private_ip
  description = "The private IP of the IPA master instance"
}

output "public_ip" {
  value       = module.ipa.public_ip
  description = "The public IP of the IPA master instance"
}

output "subnet_id" {
  value       = module.ipa.subnet_id
  description = "The ID of the subnet where the IPA master instance is deployed"
}

output "security_group_id" {
  value       = module.ipa.security_group_id
  description = "The ID of the IPA server security group"
}

output "security_group_arn" {
  value       = module.ipa.security_group_arn
  description = "The ARN of the IPA server security group"
}
