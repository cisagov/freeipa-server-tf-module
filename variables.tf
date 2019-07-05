# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "subnet_id" {
  description = "The ID of the AWS subnet to deploy into (e.g. subnet-0123456789abcdef0)"
}

variable "trusted_cidr_blocks" {
  type        = list(string)
  description = "A list of the CIDR blocks that are allowed to access the IPA servers (e.g. [\"10.10.0.0/16\", \"10.11.0.0/16\"])"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_instance_type" {
  description = "The AWS instance type to deploy (e.g. t3.micro)"
  default     = "t3.micro"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
