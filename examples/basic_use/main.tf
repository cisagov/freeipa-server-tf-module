provider "aws" {
  region = "us-west-1"
}

#-------------------------------------------------------------------------------
# Create a subnet inside a VPC.
#-------------------------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = "10.99.49.0/24"
  enable_dns_hostnames = true
}

# Setup DHCP so we can resolve our private domain
# resource "aws_vpc_dhcp_options" "dhcp_options" {
#   domain_name = local.bod_private_domain
#   domain_name_servers = [
#     "AmazonProvidedDNS",
#   ]
# }

# Associate the DHCP options above with the VPC
# resource "aws_vpc_dhcp_options_association" "vpc_dhcp" {
#   vpc_id          = aws_vpc.vpc.id
#   dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
# }

# Subnet inside the VPC
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.99.49.0/24"
  availability_zone = "us-west-1a"
}

#-------------------------------------------------------------------------------
# Configure the example module.
#-------------------------------------------------------------------------------
module "ipa" {
  source = "../../"

  subnet_id = aws_subnet.subnet.id
  trusted_cidr_blocks = [
    "10.99.49.0/24"
  ]
  tags = {
    Testing = true
  }
}
