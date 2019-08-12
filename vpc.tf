# A data source for the VPC in which the specified subnets live
data "aws_vpc" "the_vpc" {
  id = data.aws_subnet.master_subnet.vpc_id
}
