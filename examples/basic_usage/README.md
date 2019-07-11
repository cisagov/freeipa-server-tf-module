# Launch an IPA master into a VPC #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| id | The EC2 instance ID corresponding to the IPA master |
| arn | The EC2 instance ARN corresponding to the IPA master |
| availability_zone | The AZ where the IPA master instance is deployed |
| private_ip | The private IP of the IPA master instance |
| public_ip | The public IP of the IPA master instance |
| subnet_id | The ID of the subnet where the IPA master instance is deployed |
| security_group_id | The ID of the IPA server security group |
| security_group_arn | The ARN of the IPA server security group |
