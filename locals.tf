locals {
  # The ports that the IPA servers should listen on
  ipa_ports = {
    dns_tcp = {
      proto = "tcp",
      port  = 53,
    }
    dns_udp = {
      proto = "udp",
      port  = 53,
    }
    http = {
      proto = "tcp",
      port  = 80,
    },
    kinit_tcp = {
      proto = "tcp",
      port  = 88,
    },
    kinit_udp = {
      proto = "udp",
      port  = 88,
    },
    https = {
      proto = "tcp",
      port  = 443,
    },
    kpasswd_tcp = {
      proto = "tcp",
      port  = 464,
    },
    kpasswd_udp = {
      proto = "udp",
      port  = 464,
    },
    ldap = {
      proto = "tcp",
      port  = 389,
    },
    ldaps = {
      proto = "tcp",
      port  = 636,
    },
    ntp = {
      proto = "udp",
      port  = 123,
    }
  }
}
