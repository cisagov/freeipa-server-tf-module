# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "domain" {
  description = "The domain for the IPA server (e.g. example.com)"
}

variable "hostname" {
  description = "The hostname of this IPA server (e.g. ipa.example.com)"
}

variable "ip" {
  description = "The IP of this IPA server (e.g. 10.11.1.5)"
}

variable "is_master" {
  type        = bool
  description = "Indicates whether this IPA server is a master (true) or a replica (false)"
}

variable "zone_id" {
  description = "The zone ID corresponding to the Route53 zone where the kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "do_it" {
  description = "If false then no resources are created.  This is a workaround until Terraform modules support the count and/or for_each directives."
  default     = true
}

variable "ttl" {
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
