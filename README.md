# freeipa-server-tf-module #

[![GitHub Build Status](https://github.com/cisagov/freeipa-server-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/freeipa-server-tf-module/actions)

A Terraform module for deploying a FreeIPA server.

## Usage ##

```hcl
module "ipa0" {
  source = "github.com/cisagov/freeipa-server-tf-module"

  domain               = "example.com"
  hostname             = "ipa.example.com"
  ip                   = "10.10.10.4"
  realm                = "EXAMPLE.COM"
  security_group_ids   = ["sg-51530134", "sg-51530245"]
  subnet_id            = aws_subnet.first_subnet.id
  tags                 = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}

module "ipa1" {
  source = "github.com/cisagov/freeipa-server-tf-module"

  domain               = "example.com"
  hostname             = "ipa.example.com"
  ip                   = "10.10.10.5"
  security_group_ids   = ["sg-51530134", "sg-51530245"]
  subnet_id            = aws_subnet.second_subnet.id
  tags                 = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/freeipa-server-tf-module/tree/develop/examples/basic_usage)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami_owner_account_id | The ID of the AWS account that owns the FreeIPA server AMI, or "self" if the AMI is owned by the same account as the provisioner. | `string` | `self` | no |
| aws_instance_type | The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas. | `string` | `t3.medium` | no |
| domain | The domain for the IPA server (e.g. example.com). | `string` | n/a | yes |
| hostname | The hostname of the IPA server (e.g. ipa.example.com). | `string` | n/a | yes |
| ip | The IP address to assign the IPA server (e.g. 10.10.10.4).  Note that the IP address must be contained inside the CIDR block corresponding to subnet-id, and AWS reserves the first four and very last IP addresses. | `string` | n/a | yes |
| realm | The realm for the IPA server (e.g. EXAMPLE.COM).  Only used if this IPA server IS NOT intended to be a replica. | `string` | `EXAMPLE.COM` | no |
| security_group_ids | A list of IDs corresponding to security groups to which the server should belong (e,g, ["sg-51530134", "sg-51530245"]).  Note that these security groups must exist in the same VPC as the server. | `list(string)` | `[]` | no |
| subnet_id | The ID of the AWS subnet into which to deploy the IPA server (e.g. subnet-0123456789abcdef0). | `string` | n/a | yes |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| server | The IPA server EC2 instance. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every
directory that contains Terraform code. In this repository, these are
the main directory and every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
