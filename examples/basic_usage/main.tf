provider "aws" {
  profile = "cool-sharedservices-provisionaccount"
  region  = "us-east-1"
}

#-------------------------------------------------------------------------------
# Create a subnet inside a VPC.
#-------------------------------------------------------------------------------
resource "aws_vpc" "the_vpc" {
  cidr_block           = "10.99.48.0/24"
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = "10.99.48.0/24"
  availability_zone = "us-east-1a"
}

#-------------------------------------------------------------------------------
# Set up external access and routing in the VPC.
#-------------------------------------------------------------------------------

# The internet gateway for the VPC
resource "aws_internet_gateway" "the_igw" {
  vpc_id = aws_vpc.the_vpc.id
}

# Default route table
resource "aws_default_route_table" "the_route_table" {
  default_route_table_id = aws_vpc.the_vpc.default_route_table_id
}

# Route all external traffic through the internet gateway
resource "aws_route" "route_external_traffic_through_internet_gateway" {
  route_table_id         = aws_default_route_table.the_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.the_igw.id
}


#-------------------------------------------------------------------------------
# Create a private Route53 zone.
#-------------------------------------------------------------------------------
resource "aws_route53_zone" "private_zone" {
  name = "cyber.dhs.gov"

  vpc {
    vpc_id = aws_vpc.the_vpc.id
  }
}

#-------------------------------------------------------------------------------
# Create a private Route53 reverse zone.
#-------------------------------------------------------------------------------
resource "aws_route53_zone" "private_reverse_zone" {
  name = "48.99.10.in-addr.arpa"

  vpc {
    vpc_id = aws_vpc.the_vpc.id
  }
}

#-------------------------------------------------------------------------------
# Configure the server module.
#-------------------------------------------------------------------------------
module "ipa" {
  source = "../../"

  ami_owner_account_id = "207871073513" # The COOL Images account
  domain               = "cal23.cyber.dhs.gov"
  hostname             = "ipa.cal23.cyber.dhs.gov"
  reverse_zone_id      = aws_route53_zone.private_reverse_zone.zone_id
  zone_id              = aws_route53_zone.private_zone.zone_id
  realm                = "CAL23.CYBER.DHS.GOV"
  subnet_id            = aws_subnet.subnet.id
  tags = {
    Testing = true
  }
  trusted_cidr_blocks = [
    "108.31.3.53/32",
    "64.69.57.0/24",
  ]
  ttl = 60
}
