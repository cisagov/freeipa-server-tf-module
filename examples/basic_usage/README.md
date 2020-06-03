# Launch an IPA master into a VPC #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Requirements ##

No requirements.

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs ##

No input.

## Outputs ##

| Name | Description |
|------|-------------|
| ipa_client_security_group | The IPA client security group. |
| ipa_server | The IPA server EC2 instance. |
| ipa_server_security_group | The IPA server security group. |
