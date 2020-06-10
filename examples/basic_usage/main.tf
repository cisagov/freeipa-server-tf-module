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
# Configure the server module.
#-------------------------------------------------------------------------------
module "ipa" {
  source = "../../"

  ami_owner_account_id = "207871073513" # The COOL Images account
  domain               = "cal23.cyber.dhs.gov"
  hostname             = "ipa.cal23.cyber.dhs.gov"
  ip                   = "10.99.48.4"
  realm                = "CAL23.CYBER.DHS.GOV"
  subnet_id            = aws_subnet.subnet.id
  tags = {
    Testing = true
  }
}
