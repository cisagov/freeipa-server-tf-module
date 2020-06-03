# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "domain" {
  type        = string
  description = "The domain for the IPA server (e.g. example.com)."
}

variable "hostname" {
  type        = string
  description = "The hostname of the IPA server (e.g. ipa.example.com)."
}

variable "realm" {
  type        = string
  description = "The realm for the IPA server (e.g. EXAMPLE.COM)."
}

variable "reverse_zone_id" {
  type        = string
  description = "The zone ID corresponding to the private Route53 reverse zone where a PTR record related to this IPA server should be created (e.g. ZKX36JXQ8W82L)."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the AWS subnet into which to deploy the IPA server (e.g. subnet-0123456789abcdef0)."
}

variable "zone_id" {
  type        = string
  description = "The zone ID corresponding to the private Route53 zone where an A record should be created for the IPA server (e.g. ZKX36JXQ8W82L)."
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "ami_owner_account_id" {
  type        = string
  description = "The ID of the AWS account that owns the FreeIPA server AMI, or \"self\" if the AMI is owned by the same account as the provisioner."
  default     = "self"
}

variable "aws_instance_type" {
  type        = string
  description = "The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas."
  default     = "t3.medium"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

variable "trusted_cidr_blocks" {
  type        = list(string)
  description = "A list of the CIDR blocks outside the VPC that are allowed to access the IPA servers (e.g. [\"10.10.0.0/16\", \"10.11.0.0/16\"])."
  default     = []
}

variable "ttl" {
  type        = number
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
