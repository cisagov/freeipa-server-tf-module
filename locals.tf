locals {
  # The TCP ports that the IPA servers should listen on
  ipa_tcp_ports = [
    88,  # Kerberos
    464, # kpasswd
    389, # LDAP
  ]

  # The UDP ports that the IPA servers should listen on
  ipa_udp_ports = [
    88,  # Kerberos
    464, # kpasswd
  ]
}
