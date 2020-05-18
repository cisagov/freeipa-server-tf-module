# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "hostname" {
  type        = string
  description = "The hostname of the IPA master (e.g. ipa.example.com)"
}

variable "domain" {
  type        = string
  description = "The domain for the IPA master (e.g. example.com)"
}

variable "private_ip" {
  type        = string
  description = "The private IP of the IPA master (e.g. 10.11.1.5)"
}

variable "private_reverse_zone_id" {
  type        = string
  description = "The zone ID corresponding to the private Route53 reverse zone where the PTR records related to the IPA master should be created (e.g. ZKX36JXQ8W82L)"
}

variable "private_zone_id" {
  type        = string
  description = "The zone ID corresponding to the private Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether or not to associate a public IP address with the IPA master"
  default     = false
}

variable "public_zone_id" {
  type        = string
  description = "The zone ID corresponding to the public Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L).  Only required if a public IP address is associated with the IPA master (i.e. if associate_public_ip_address is true)."
  default     = ""
}

variable "public_ip" {
  type        = string
  description = "The public IP of the IPA master (e.g. 10.11.1.5), if one exists"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "ttl" {
  type        = number
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
