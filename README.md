# freeipa-master-tf-module #

[![GitHub Build Status](https://github.com/cisagov/freeipa-master-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/freeipa-master-tf-module/actions)

A Terraform module for deploying a FreeIPA master into a VPC.

## Usage ##

```hcl
module "ipa_master" {
  source = "github.com/cisagov/freeipa-master-tf-module"

  aws_instance_type   = "t3.large"
  domain              = "example.com"
  hostname            = "ipa.example.com"
  reverse_zone_id     = "ZLY47KYR9X93M"
  zone_id             = "ZKX36JXQ8W82L"
  realm               = "EXAMPLE.COM"
  subnet_id           = aws_subnet.master_subnet.id
  tags                = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
  trusted_cidr_blocks = [
    "10.99.49.0/24",
    "10.99.52.0/24"
  ]
  ttl                 = 60
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/freeipa-master-tf-module/tree/develop/examples/basic_usage)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami_owner_account_id | The ID of the AWS account that owns the FreeIPA server AMI, or "self" if the AMI is owned by the same account as the provisioner. | `string` | `self` | no |
| aws_instance_type | The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas. | `string` | `t3.medium` | no |
| domain | The domain for the IPA server (e.g. example.com). | `string` | n/a | yes |
| hostname | The hostname of the IPA server (e.g. ipa.example.com). | `string` | n/a | yes |
| realm | The realm for the IPA server (e.g. EXAMPLE.COM). | `string` | n/a | yes |
| reverse_zone_id | The zone ID corresponding to the private Route53 reverse zone where a PTR record related to this IPA server should be created (e.g. ZKX36JXQ8W82L). | `string` | n/a | yes |
| subnet_id | The ID of the AWS subnet into which to deploy the IPA server (e.g. subnet-0123456789abcdef0). | `string` | n/a | yes |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| trusted_cidr_blocks | A list of the CIDR blocks outside the VPC that are allowed to access the IPA servers (e.g. ["10.10.0.0/16", "10.11.0.0/16"]). | `list(string)` | `[]` | no |
| ttl | The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing. | `number` | `86400` | no |
| zone_id | The zone ID corresponding to the private Route53 zone where an A record should be created for the IPA server (e.g. ZKX36JXQ8W82L). | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| client_security_group | The IPA client security group. |
| server | The IPA server EC2 instance. |
| server_security_group | The IPA server security group. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every
directory that contains Terraform code. In this repository, these are
the main directory and the `dns` and `dns/route53` directories under
the main directory, as well as every directory under `examples/`.

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
