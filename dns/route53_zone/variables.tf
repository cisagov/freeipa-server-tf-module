# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "domain" {
  type        = string
  description = "The domain for the IPA master (e.g. example.com)"
}

variable "hostname" {
  type        = string
  description = "The hostname of the IPA master (e.g. ipa.example.com)"
}

variable "ip" {
  type        = string
  description = "The IP of the IPA master (e.g. 10.11.1.5)"
}

variable "zone_id" {
  type        = string
  description = "The zone ID corresponding to the Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "ttl" {
  type        = number
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
