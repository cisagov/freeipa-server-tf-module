# Launch an IPA master into a VPC #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| master_id | The EC2 instance ID corresponding to the IPA master |
| master_arn | The EC2 instance ARN corresponding to the IPA master |
| master_availability_zone | The AZ where the IPA master instance is deployed |
| master_private_ip | The private IP of the IPA master instance |
| master_public_ip | The public IP of the IPA master instance |
| master_subnet_id | The ID of the subnet where the IPA master instance is deployed |
| replica_ids | The EC2 instance IDs corresponding to the IPA replicas |
| replica_arns | The EC2 instance ARNs corresponding to the IPA replicas |
| replica_availability_zones | The AZ where the IPA replica instances are deployed |
| replica_private_ips | The private IPs of the IPA replica instances |
| replica_public_ips | The public IPs of the IPA replica instances |
| replica_subnet_ids | The IDs of the subnets where the IPA replica instances are deployed |
| security_group_id | The ID of the IPA server security group |
| security_group_arn | The ARN of the IPA server security group |
