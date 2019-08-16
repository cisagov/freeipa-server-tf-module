provider "aws" {
  region = "us-west-1"
}

#-------------------------------------------------------------------------------
# Create two subnets inside a VPC.
#-------------------------------------------------------------------------------
resource "aws_vpc" "the_vpc" {
  cidr_block           = "10.99.48.0/23"
  enable_dns_hostnames = true
}

resource "aws_subnet" "master_subnet" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = "10.99.48.0/24"
  availability_zone = "us-west-1b"
}

resource "aws_subnet" "replica_subnet" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = "10.99.49.0/24"
  availability_zone = "us-west-1c"
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
# Create private Route53 reverse zones.
#-------------------------------------------------------------------------------
resource "aws_route53_zone" "master_private_reverse_zone" {
  name = "48.99.10.in-addr.arpa"

  vpc {
    vpc_id = aws_vpc.the_vpc.id
  }
}

resource "aws_route53_zone" "replica_private_reverse_zone" {
  name = "49.99.10.in-addr.arpa"

  vpc {
    vpc_id = aws_vpc.the_vpc.id
  }
}

#-------------------------------------------------------------------------------
# Create a data resource for the existing public Route53 zone.
#-------------------------------------------------------------------------------
data "aws_route53_zone" "public_zone" {
  name = "cyber.dhs.gov."
}

#-------------------------------------------------------------------------------
# Configure the master and replica modules.
#-------------------------------------------------------------------------------
module "ipa_master" {
  source = "../../"

  providers = {
    aws     = "aws"
    aws.dns = "aws"
  }

  admin_pw                    = "thepassword"
  associate_public_ip_address = true
  directory_service_pw        = "thepassword"
  domain                      = "cal23.cyber.dhs.gov"
  hostname                    = "ipa.cal23.cyber.dhs.gov"
  is_master                   = true
  private_reverse_zone_id     = aws_route53_zone.master_private_reverse_zone.zone_id
  private_zone_id             = aws_route53_zone.private_zone.zone_id
  public_zone_id              = data.aws_route53_zone.public_zone.zone_id
  realm                       = "CAL23.CYBER.DHS.GOV"
  subnet_id                   = aws_subnet.master_subnet.id
  tags = {
    Testing = true
  }
  trusted_cidr_blocks = [
    "10.99.48.0/23",
    "108.31.3.53/32"
  ]
  ttl = 60
}

module "ipa_replica1" {
  source = "../../"

  providers = {
    aws     = "aws"
    aws.dns = "aws"
  }

  admin_pw                    = "thepassword"
  associate_public_ip_address = true
  hostname                    = "ipa-replica1.cal23.cyber.dhs.gov"
  is_master                   = false
  master_hostname             = "ipa.cal23.cyber.dhs.gov"
  private_reverse_zone_id     = aws_route53_zone.replica_private_reverse_zone.zone_id
  private_zone_id             = aws_route53_zone.private_zone.zone_id
  public_zone_id              = data.aws_route53_zone.public_zone.zone_id
  server_security_group_id    = module.ipa_master.server_security_group_id
  subnet_id                   = aws_subnet.replica_subnet.id
  tags = {
    Testing = true
  }
  ttl = 60
}
