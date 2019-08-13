# The IPA master EC2 instance
resource "aws_instance" "ipa_master" {
  ami                         = data.aws_ami.freeipa.id
  ebs_optimized               = true
  instance_type               = var.aws_instance_type
  availability_zone           = data.aws_subnet.master_subnet.availability_zone
  subnet_id                   = var.master_subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = [
    aws_security_group.ipa_clients.id,
    aws_security_group.ipa_servers.id,
  ]

  user_data_base64 = data.template_cloudinit_config.master_cloud_init_tasks.rendered

  tags        = var.tags
  volume_tags = var.tags
}


# The IPA replica EC2 instances
resource "aws_instance" "ipa_replicas" {
  count = length(data.aws_subnet.replica_subnets)

  ami                         = data.aws_ami.freeipa.id
  ebs_optimized               = true
  instance_type               = var.aws_instance_type
  availability_zone           = data.aws_subnet.replica_subnets[count.index].availability_zone
  subnet_id                   = var.replica_subnet_ids[count.index]
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = [
    aws_security_group.ipa_clients.id,
    aws_security_group.ipa_servers.id,
  ]

  user_data_base64 = data.template_cloudinit_config.replica_cloud_init_tasks[count.index].rendered

  tags        = var.tags
  volume_tags = var.tags
}
