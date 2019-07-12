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

  tcp_and_udp = [
    "tcp",
    "udp"
  ]
}
