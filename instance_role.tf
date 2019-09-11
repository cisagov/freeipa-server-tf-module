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

# # IAM policy document that that allows read access to the certboto
# # certificate data.  This will be applied to the role we are creating.
# data "aws_iam_policy_document" "s3_doc" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#     ]

#     resources = [
#       "arn:aws:s3:::cert-bucket-name/live/${var.hostname}/*",
#     ]
#   }
# }

# # The S3 policy for our role
# resource "aws_iam_role_policy" "s3_policy" {
#   provider = aws.certs

#   role   = aws_iam_role.ipa.id
#   policy = data.aws_iam_policy_document.s3_doc.json
# }

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

# The instance profile to be used by the IPA master EC2 instance.
resource "aws_iam_instance_profile" "ipa" {
  role = aws_iam_role.ipa.name
}
