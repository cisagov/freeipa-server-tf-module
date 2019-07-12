# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_pw" {
  description = "The admin password for the IPA server's Kerberos admin role"
}

variable "directory_service_pw" {
  description = "The password for the IPA server's directory service"
}

variable "domain" {
  description = "The domain for the IPA server (e.g. example.com)"
}

variable "hostname" {
  description = "The hostname of the IPA server (e.g. ipa.example.com)"
}

variable "private_zone_id" {
  description = "The zone ID corresponding to the private Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "private_reverse_zone_id" {
  description = "The zone ID corresponding to the private Route53 reverse zone where the PTR records for the kerberos-related A records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "public_zone_id" {
  description = "The zone ID corresponding to the public Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "realm" {
  description = "The realm for the IPA server (e.g. EXAMPLE.COM)"
}

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

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether or not to associate a public IP address with the IPA server"
  default     = false
}

variable "aws_instance_type" {
  description = "The AWS instance type to deploy (e.g. t3.medium).  Two gigs of RAM is a minimum requirement."
  default     = "t3.small"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
