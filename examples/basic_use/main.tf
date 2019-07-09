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
# Configure the example module.
#-------------------------------------------------------------------------------
module "ipa" {
  source = "../../"

  directory_service_pw = "thepassword"
  admin_pw             = "thepassword"
  domain               = "cal.cyber.dhs.gov"
  hostname             = "ipa.cal.cyber.dhs.gov"
  realm                = "CAL.CYBER.DHS.GOV"
  subnet_id            = aws_subnet.the_subnet.id
  trusted_cidr_blocks = [
    "10.99.49.0/24",
    "108.31.3.53/32"
  ]
  associate_public_ip_address = true
  tags = {
    Testing = true
  }
}
