# freeipa-server-tf-module #

[![Build Status](https://travis-ci.com/cisagov/freeipa-server-tf-module.svg?branch=develop)](https://travis-ci.com/cisagov/freeipa-server-tf-module)

A Terraform module for deploying a FreeIPA server (master or replica)
into a VPC.

## Usage ##

Master IPA server:

```hcl
module "ipa_master" {
  source = "github.com/cisagov/freeipa-server-tf-module"

  admin_pw                    = "thepassword"
  associate_public_ip_address = true
  aws_instance_type           = "t3.large"
  directory_service_pw        = "thepassword"
  domain                      = "example.com"
  hostname                    = "ipa.example.com"
  is_master                   = true
  private_reverse_zone_id     = "ZLY47KYR9X93M"
  private_zone_id             = "ZKX36JXQ8W82L"
  public_zone_id              = "ZJW25IWP7V71K"
  realm                       = "EXAMPLE.COM"
  subnet_id                   = aws_subnet.master_subnet.id
  tags                        = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
  trusted_cidr_blocks         = [
    "10.99.49.0/24",
    "10.99.52.0/24"
  ]
  ttl                         = 60
}
```

Replica IPA server:

```hcl
module "ipa_replica" {
  source = "github.com/cisagov/freeipa-server-tf-module"

  admin_pw                    = "thepassword"
  associate_public_ip_address = true
  aws_instance_type           = "t3.large"
  hostname                    = "ipa-replica1.example.com"
  is_master                   = false
  private_reverse_zone_id     = "ZLY47KYR9X93M"
  private_zone_id             = "ZKX36JXQ8W82L"
  public_zone_id              = "ZJW25IWP7V71K"
  server_security_group_id    = module.ipa_master.server_security_group_id
  subnet_id                   = aws_subnet.replica_subnet.id
  tags                        = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
  ttl                         = 60
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/freeipa-server-tf-module/tree/develop/examples/basic_usage)

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| admin_pw | The ID of the AWS account that owns the FreeIPA server AMI | string | `344440683180` | no |
| admin_pw | The admin password for the Kerberos admin role | string | | yes |
| associate_public_ip_address | Whether or not to associate a public IP address with the IPA server | bool | `false` | no |
| aws_instance_type | The AWS instance type to deploy (e.g. t3.medium).  Two gigs of RAM is a minimum requirement. | string | `t3.medium` | no |
| directory_service_pw | The password for the IPA server's directory service.  Only required if this is a master IPA server (i.e. if is_master is true). | string | Empty string | no |
| domain | The domain for the IPA server (e.g. `example.com`).  Only required if this is a master IPA server (i.e. if is_master is true). | string | Empty string | no |
| hostname | The hostname of this IPA server (e.g. `ipa.example.com`) | string | | yes |
| is_master | Indicates whether this IPA server is a master (true) or a replica (false) | bool | | yes |
| master_hostname | The hostname of the IPA master (e.g. ipa.example.com).  Only necessary if creating a replica IPA server and you want the replica to delay installation until the master is available. | string | Empty string | no |
| private_reverse_zone_id | The zone ID corresponding to the private Route53 reverse zone where the PTR records related to this IPA server should be created (e.g. `ZKX36JXQ8W82L`) | string | | yes |
| private_zone_id | The zone ID corresponding to the private Route53 zone where the kerberos-related DNS records should be created (e.g. `ZKX36JXQ8W82L`) | string | | yes |
| public_zone_id | The zone ID corresponding to the public Route53 zone where the kerberos-related DNS records should be created (e.g. `ZKX36JXQ8W82L`) | string | Empty string | no |
| realm | The realm for the IPA server (e.g. `EXAMPLE.COM`).  Only required if this is a master IPA server (i.e. if is_master is true). | string | Empty string | no |
| server_security_group_id | The ID for the IPA server security group (e.g. sg-0123456789abcdef0).  Only required if this is a replica IPA server (i.e. if is_master is false). | string | Empty string | no |
| subnet_id | The ID of the AWS subnet into which to deploy this IPA server (e.g. `subnet-0123456789abcdef0`) | string | | yes |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |
| trusted_cidr_blocks | A list of the CIDR blocks that are allowed to access the IPA servers (e.g. `[10.10.0.0/16, 10.11.0.0/16]`).  Only used if this is a master IPA server (i.e. if is_master is true). | list(string) | `[]` | no |
| ttl | The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing. | string | `86400` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| id | The EC2 instance ID corresponding to the IPA server |
| server_security_group_id | The ID of the IPA server security group |

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
