provider "aws" {
  region = "us-west-1"
}

#-------------------------------------------------------------------------------
# Create a subnet inside a VPC.
#-------------------------------------------------------------------------------
resource "aws_vpc" "the_vpc" {
  cidr_block           = "10.99.49.0/24"
  enable_dns_hostnames = true
}

resource "aws_subnet" "the_subnet" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = "10.99.49.0/24"
  availability_zone = "us-west-1a"
}

#-------------------------------------------------------------------------------
# Create a Route53 zone.
#-------------------------------------------------------------------------------
resource "aws_route53_zone" "the_zone" {
  name = "freeipa.test."
}

#-------------------------------------------------------------------------------
# Configure the example module.
#-------------------------------------------------------------------------------
module "ipa" {
  source = "../../"

  subnet_id = aws_subnet.the_subnet.id
  trusted_cidr_blocks = [
    "10.99.49.0/24"
  ]
  zone_name = aws_route53_zone.the_zone.name
  tags = {
    Testing = true
  }
}
