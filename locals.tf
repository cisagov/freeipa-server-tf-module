locals {
  # The TCP ports that the IPA servers should listen on
  ipa_tcp_ports = [
    53,  # DNS
    80,  # HTTP
    88,  # kinit
    443, # HTTPS
    464, # kpasswd
    389, # LDAP
    636, # LDAPS
  ]

  # The UDP ports that the IPA servers should listen on
  ipa_udp_ports = [
    53,  # DNS
    88,  # kinit
    123, # NTP
    464, # kpasswd
  ]
}
