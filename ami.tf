# ------------------------------------------------------------------------------
# Deploy the AMI from cisagov/freeipa-packer in AWS.
# ------------------------------------------------------------------------------

# The AWS account ID being used
data "aws_caller_identity" "current" {}

# ------------------------------------------------------------------------------
# Automatically look up the latest pre-built example AMI from
# cisagov/freeipa-packer.
#
# NOTE: This Terraform data source must return at least one AMI result
# or the apply will fail.
# ------------------------------------------------------------------------------

# The AMI from cisagov/freeipa-packer
data "aws_ami" "freeipa" {
  filter {
    name = "name"
    values = [
      "freeipa-hvm-*-x86_64-ebs",
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners      = [data.aws_caller_identity.current.account_id] # This is us
  most_recent = true
}
