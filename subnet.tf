# A data source for the subnet specified
data "aws_subnet" "the_subnet" {
  id = var.subnet_id
}
