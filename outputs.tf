output "master_id" {
  value       = aws_instance.ipa_master.id
  description = "The EC2 instance ID corresponding to the IPA master"
}

output "master_arn" {
  value       = aws_instance.ipa_master.arn
  description = "The EC2 instance ARN corresponding to the IPA master"
}

output "master_availability_zone" {
  value       = aws_instance.ipa_master.availability_zone
  description = "The AZ where the IPA master instance is deployed"
}

output "master_private_ip" {
  value       = aws_instance.ipa_master.private_ip
  description = "The private IP of the IPA master instance"
}

output "master_subnet_id" {
  value       = aws_instance.ipa_master.subnet_id
  description = "The ID of the subnet where the IPA master instance is deployed"
}

output "master_security_group_id" {
  value       = aws_security_group.ipa_servers.id
  description = "The ID of the IPA server security group"
}

output "master_security_group_arn" {
  value       = aws_security_group.ipa_servers.arn
  description = "The ARN of the IPA server security group"
}
