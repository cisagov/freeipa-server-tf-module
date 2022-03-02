# Create a role that allows the reading of certain SSM parameters
# necessary to link to the CDM Nessus/Tenable server
module "read_ssm_parameters" {
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = aws.provision_ssm_parameter_read_role
  }

  # Allow the account where the instance is being created to assume
  # this role, which lives in the Images account.
  account_ids = [data.aws_caller_identity.main.account_id]
  entity_name = var.fqdn
  ssm_names = [
    var.nessus_hostname_key,
    var.nessus_key_key,
    var.nessus_port_key,
  ]
}

# Create a policy that allows the SSM read role to be assumed
data "aws_iam_policy_document" "assume_delegated_role_policy_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      module.read_ssm_parameters.role.arn,
    ]
  }
}

# IAM assume role policy document for the instance role to be used by
# the IPA master EC2 instance
data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# The instance role to be used by the IPA master EC2 instance
resource "aws_iam_role" "ipa" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
}

# Attach the policy to assume the delegated role to this role
resource "aws_iam_role_policy" "assume_delegated_role_policy" {
  policy = data.aws_iam_policy_document.assume_delegated_role_policy_doc.json
  role   = aws_iam_role.ipa.id
}

# Attach the CloudWatch Agent policy to this role as well
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy_attachment" {
  role       = aws_iam_role.ipa.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Attach the SSM Agent policy to this role as well
resource "aws_iam_role_policy_attachment" "ssm_agent_policy_attachment" {
  role       = aws_iam_role.ipa.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# The instance profile to be used by the IPA master EC2 instance.
resource "aws_iam_instance_profile" "ipa" {
  role = aws_iam_role.ipa.name
}
