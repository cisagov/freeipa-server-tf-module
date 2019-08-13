output "client_security_group_arn" {
  value       = aws_security_group.ipa_clients.arn
  description = "The ARN of the IPA client security group"
}

output "client_security_group_id" {
  value       = aws_security_group.ipa_clients.id
  description = "The ID of the IPA client security group"
}

output "master_arn" {
  value       = aws_instance.ipa_master.arn
  description = "The EC2 instance ARN corresponding to the IPA master"
}

output "master_availability_zone" {
  value       = aws_instance.ipa_master.availability_zone
  description = "The AZ where the IPA master instance is deployed"
}

output "master_id" {
  value       = aws_instance.ipa_master.id
  description = "The EC2 instance ID corresponding to the IPA master"
}

output "master_private_ip" {
  value       = aws_instance.ipa_master.private_ip
  description = "The private IP of the IPA master instance"
}

output "master_public_ip" {
  value       = aws_instance.ipa_master.public_ip
  description = "The public IP of the IPA master instance"
}

output "master_subnet_id" {
  value       = aws_instance.ipa_master.subnet_id
  description = "The ID of the subnet where the IPA master instance is deployed"
}

output "replica_arns" {
  value       = aws_instance.ipa_replicas[*].arn
  description = "The EC2 instance ARNs corresponding to the IPA replicas"
}

output "replica_ids" {
  value       = aws_instance.ipa_replicas[*].id
  description = "The EC2 instance IDs corresponding to the IPA replicas"
}

output "replica_availability_zones" {
  value       = aws_instance.ipa_replicas[*].availability_zone
  description = "The AZs where the IPA replica instances are deployed"
}

output "replica_private_ips" {
  value       = aws_instance.ipa_replicas[*].private_ip
  description = "The private IPs of the IPA replica instances"
}

output "replica_public_ips" {
  value       = aws_instance.ipa_replicas[*].public_ip
  description = "The public IPs of the IPA replica instances"
}

output "replica_subnet_ids" {
  value       = aws_instance.ipa_replicas[*].subnet_id
  description = "The IDs of the subnets where the IPA replica instances are deployed"
}

output "server_security_group_arn" {
  value       = aws_security_group.ipa_servers.arn
  description = "The ARN of the IPA server security group"
}

output "server_security_group_id" {
  value       = aws_security_group.ipa_servers.id
  description = "The ID of the IPA server security group"
}
