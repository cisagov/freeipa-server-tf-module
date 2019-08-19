# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_pw" {
  description = "The password for the Kerberos admin role"
}

variable "directory_service_pw" {
  description = "The password for the IPA master's directory service"
}

variable "domain" {
  description = "The domain for the IPA master (e.g. example.com)"
}

variable "hostname" {
  description = "The hostname of the IPA master (e.g. ipa.example.com)"
}

variable "private_reverse_zone_id" {
  description = "The zone ID corresponding to the private Route53 reverse zone where the PTR records related to the IPA master should be created (e.g. ZKX36JXQ8W82L)"
}

variable "private_zone_id" {
  description = "The zone ID corresponding to the private Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "realm" {
  description = "The realm for the IPA server (e.g. EXAMPLE.COM)"
}

variable "subnet_id" {
  description = "The ID of the AWS subnet into which to deploy the IPA master (e.g. subnet-0123456789abcdef0)"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "ami_owner_account_id" {
  description = "The ID of the AWS account that owns the FreeIPA server AMI"
  default     = "344440683180" # CISA NCATS CyHy production (Raytheon) account
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether or not to associate a public IP address with the IPA master"
  default     = false
}

variable "aws_instance_type" {
  description = "The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas."
  default     = "t3.medium"
}

variable "public_zone_id" {
  description = "The zone ID corresponding to the public Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L).  Only required if a public IP address is associated with the IPA master (i.e. if associate_public_ip_address is true)."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "trusted_cidr_blocks" {
  type        = list(string)
  description = "A list of the CIDR blocks outside the VPC that are allowed to access the IPA servers (e.g. [\"10.10.0.0/16\", \"10.11.0.0/16\"])"
  default     = []
}

variable "ttl" {
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
