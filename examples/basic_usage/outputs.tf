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

output "replica_ids" {
  value       = module.ipa.replica_ids
  description = "The EC2 instance IDs corresponding to the IPA replicas"
}

output "replica_arns" {
  value       = module.ipa.replica_arns
  description = "The EC2 instance ARNs corresponding to the IPA replicas"
}

output "replica_availability_zones" {
  value       = module.ipa.replica_availability_zones
  description = "The AZs where the IPA replica instances are deployed"
}

output "replica_private_ips" {
  value       = module.ipa.replica_private_ips
  description = "The private IPs of the IPA replica instances"
}

output "replica_public_ips" {
  value       = module.ipa.replica_public_ips
  description = "The public IPs of the IPA replica instances"
}

output "replica_subnet_ids" {
  value       = module.ipa.replica_subnet_ids
  description = "The IDs of the subnets where the IPA replica instances are deployed"
}

output "security_group_id" {
  value       = module.ipa.security_group_id
  description = "The ID of the IPA server security group"
}

output "security_group_arn" {
  value       = module.ipa.security_group_arn
  description = "The ARN of the IPA server security group"
}
