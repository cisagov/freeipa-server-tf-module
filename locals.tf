locals {
  # The TCP ports that the IPA servers should listen on
  ipa_tcp_ports = [
    22,  # SSH
    80,  # HTTP
    88,  # kinit
    443, # HTTPS
    464, # kpasswd
    389, # LDAP
    636, # LDAPS
  ]

  # The UDP ports that the IPA servers should listen on
  ipa_udp_ports = [
    88,  # kinit
    464, # kpasswd
  ]

  # If this is a master IPA server then we will create the security
  # group.  Otherwise it is passed in.
  server_security_group_id = var.is_master ? aws_security_group.ipa_servers[0].id : var.server_security_group_id
}
