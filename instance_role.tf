# IAM assume role policy document for the S3 certboto certificate
# access role to be used by the IPA master EC2 instance
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

# The S3 certificate access role to be used by the IPA master EC2
# instance
resource "aws_iam_role" "ipa" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
}

# IAM policy document that allows assumption of a delegated role
data "aws_iam_policy_document" "assume_delegated_role_policy_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      var.cert_read_role_arn
    ]
  }
}

# The delegated role policy for our role
resource "aws_iam_role_policy" "assume_delegated_role_policy" {
  role   = aws_iam_role.ipa.id
  policy = data.aws_iam_policy_document.assume_delegated_role_policy_doc.json
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
