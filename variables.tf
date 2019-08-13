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

variable "master_hostname" {
  description = "The hostname of the IPA master (e.g. ipa.example.com)"
}

variable "master_private_reverse_zone_id" {
  description = "The zone ID corresponding to the private Route53 reverse zone where the PTR records related to the kerberos master should be created (e.g. ZKX36JXQ8W82L)"
}

variable "master_subnet_id" {
  description = "The ID of the AWS subnet into which to deploy the master IPA server (e.g. subnet-0123456789abcdef0)"
}

variable "private_zone_id" {
  description = "The zone ID corresponding to the private Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "public_zone_id" {
  description = "The zone ID corresponding to the public Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "realm" {
  description = "The realm for the IPA server (e.g. EXAMPLE.COM)"
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
  description = "Whether or not to associate a public IP address with the IPA server and replicas"
  default     = false
}

variable "aws_instance_type" {
  description = "The AWS instance type to deploy (e.g. t3.medium).  Two gigs of RAM is a minimum requirement."
  default     = "t3.small"
}

variable "replica_hostnames" {
  type        = list(string)
  description = "The hostnames of the IPA replicas (e.g. `[ipa-replica1.example.com]`)"
}

variable "replica_private_reverse_zone_ids" {
  type        = list(string)
  description = "The zone IDs corresponding to the private Route53 reverse zones where the PTR records related to the kerberos replicas should be created (e.g. [ZKX36JXQ8W82L])"
}

variable "replica_subnet_ids" {
  type        = list(string)
  description = "The IDs of the AWS subnets into which to deploy the replica IPA servers (e.g. [subnet-0123456789abcdef0])"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "ttl" {
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
