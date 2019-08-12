# A data source for the master subnet specified
data "aws_subnet" "master_subnet" {
  id = var.master_subnet_id
}

# Data sources for the replica subnets specified
data "aws_subnet" "replica_subnets" {
  count = length(var.replica_subnet_ids)

  id = var.replica_subnet_ids[count.index]
}
