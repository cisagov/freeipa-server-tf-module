# The IPA master EC2 instance
resource "aws_instance" "ipa" {
  ami                         = data.aws_ami.freeipa.id
  instance_type               = var.aws_instance_type
  availability_zone           = data.aws_subnet.the_subnet.availability_zone
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  private_ip                  = var.ip
  vpc_security_group_ids      = var.security_group_ids
  user_data_base64            = data.cloudinit_config.configure_freeipa.rendered
  iam_instance_profile        = aws_iam_instance_profile.ipa.name
  tags                        = var.tags
  volume_tags                 = var.tags
}
