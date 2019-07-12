# freeipa-server-tf-module #

[![Build Status](https://travis-ci.com/cisagov/freeipa-server-tf-module.svg?branch=develop)](https://travis-ci.com/cisagov/freeipa-server-tf-module)

A Terraform module for deploying a FreeIPA master server into a VPC.

## Usage ##

```hcl
module "ipa" {
  source = "github.com/cisagov/freeipa-server-tf-module"

  admin_pw                = "thepassword"
  directory_service_pw    = "thepassword"
  domain                  = "example.com"
  hostname                = "ipa.example.com"
  private_zone_ip         = "ZKX36JXQ8W82L"
  private_reverse_zone_ip = "ZLY47KYR9X93M"
  public_zone_ip          = "ZJW25IWP7V71K"
  realm                   = "EXAMPLE.COM"
  subnet_id               = aws_subnet.the_subnet.id
  trusted_cidr_blocks     = [
    "10.99.49.0/24",
    "10.99.52.0/24"
  ]
  associate_public_ip_address = true
  aws_instance_type = "t3.large"
  tags = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/freeipa-server-tf-module/tree/develop/examples/basic_usage)

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| admin_pw | The admin password for the IPA server's Kerberos admin role | string | | yes |
| directory_service_pw | The password for the IPA server's directory service | string | | yes |
| domain | The domain for the IPA server (e.g. `example.com`) | string | | yes |
| hostname | The hostname of the IPA server (e.g. `ipa.example.com`) | string | | yes |
| private_zone_id | The zone ID corresponding to the private Route53 zone where the kerberos-related DNS records should be created (e.g. `ZKX36JXQ8W82L`) | string | | yes |
| private_reverse_zone_id | The zone ID corresponding to the private Route53 reverse zone where the PTR records for the kerberos-related A records should be created (e.g. `ZKX36JXQ8W82L`) | string | | yes |
| public_zone_id | The zone ID corresponding to the public Route53 zone where the kerberos-related DNS records should be created (e.g. `ZKX36JXQ8W82L`) | string | | yes |
| realm | The realm for the IPA server (e.g. `EXAMPLE.COM`) | string | | yes |
| subnet_id | The ID of the AWS subnet to deploy into (e.g. `subnet-0123456789abcdef0`) | string | | yes |
| trusted_cidr_blocks | A list of the CIDR blocks that are allowed to access the IPA servers (e.g. `[10.10.0.0/16, 10.11.0.0/16]`) | list(string) | | yes |
| associate_public_ip_address | Whether or not to associate a public IP address with the IPA server | bool | `false` | no |
| aws_instance_type | The AWS instance type to deploy (e.g. t3.medium).  Two gigs of RAM is a minimum requirement. | string | `t3.small` | no |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |
| ttl | The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing. | string | `86400` | no |

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
