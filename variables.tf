# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_pw" {
  description = "The password for the Kerberos admin role"
}

variable "hostname" {
  description = "The hostname of this IPA server (e.g. ipa.example.com)"
}

variable "is_master" {
  type        = bool
  description = "Indicates whether this IPA server is a master (true) or a replica (false)"
}

variable "private_reverse_zone_id" {
  description = "The zone ID corresponding to the private Route53 reverse zone where the PTR records related to this IPA server should be created (e.g. ZKX36JXQ8W82L)"
}

variable "private_zone_id" {
  description = "The zone ID corresponding to the private Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "subnet_id" {
  description = "The ID of the AWS subnet into which to deploy this IPA server (e.g. subnet-0123456789abcdef0)"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether or not to associate a public IP address with the IPA server"
  default     = false
}

variable "aws_instance_type" {
  description = "The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas."
  default     = "t3.medium"
}

variable "directory_service_pw" {
  description = "The password for the IPA server's directory service.  Only required if this is a master IPA server (i.e. if is_master is true)."
  default     = ""
}

variable "domain" {
  description = "The domain for the IPA server (e.g. example.com).  Only required if this is a master IPA server (i.e. if is_master is true)."
  default     = ""
}

variable "master_hostname" {
  description = "The hostname of the IPA master (e.g. ipa.example.com).  Only necessary if creating a replica IPA server and you want the replica to delay installation until the master is available."
  default     = ""
}

variable "public_zone_id" {
  description = "The zone ID corresponding to the public Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L).  Only required if a public IP address is associated with the IPA server (i.e. if associate_public_ip_address is true)."
  default     = ""
}

variable "realm" {
  description = "The realm for the IPA server (e.g. EXAMPLE.COM).  Only required if this is a master IPA server (i.e. if is_master is true)."
  default     = ""
}

variable "server_security_group_id" {
  description = "The ID for the IPA server security group (e.g. sg-0123456789abcdef0).  Only required if this is a replica IPA server (i.e. if is_master is false)."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "trusted_cidr_blocks" {
  type        = list(string)
  description = "A list of the CIDR blocks that are allowed to access the IPA servers (e.g. [\"10.10.0.0/16\", \"10.11.0.0/16\"]).  Only used if this is a master IPA server (i.e. if is_master is true)."
  default     = []
}

variable "ttl" {
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
