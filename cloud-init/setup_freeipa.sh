#!/usr/bin/env bash

# Input variables are:
# admin_pw - the admin password for the IPA server's Kerberos admin
# role
# directory_service_pw - the password for the IPA server's directory
# service
# domain - the domain for the IPA server (e.g. example.com)
# hostname - the hostname of the IPA server (e.g. ipa.example.com)
# realm - the realm for the IPA server (e.g. EXAMPLE.COM)
# reverse_zone_name - the name to use for the reverse zone created by
# IPA

set -o nounset
set -o errexit
set -o pipefail

# Get the default Ethernet interface
function get_interface {
    ip route | grep default | sed "s/^.* dev \([^ ]*\).*$/\1/"
}

# Get the IP address corresponding to an interface
function get_ip {
    ip --family inet address show dev "$1" | \
        grep inet | \
        sed "s/^ *//" | \
        cut --delimiter=' ' --fields=2 | \
        cut --delimiter='/' --fields=1
}

# Get the PTR record corresponding to an IP
function get_ptr {
    dig +noall +ans -x "$1" | sed "s/.*PTR[[:space:]]*\(.*\)/\1/"
}

interface=$(get_interface)
ip_address=$(get_ip "$interface")
# Replace last octet with a 2.  This gives the address of the DNS
# server provided by AWS.
dns_forward_ip=${ip_address%.[0-9]*}.

# Wait until the IP address has a non-Amazon PTR record before
# proceeding
ptr=$(get_ptr "$ip_address")
while grep amazon <<< "$ptr"
do
    sleep 30
    ptr=$(get_ptr "$ip_address")
done

# There are several items below that look like shell variables but are
# actually replaced by the Terraform templating engine.  Hence we can
# ignore the "undefined variable" warnings from shellcheck.
#
# shellcheck disable=SC2154
ipa-server-install --realm="${realm}" \
                   --domain="${domain}" \
                   --ds-password="${directory_service_pw}" \
                   --admin-password="${admin_pw}" \
                   --hostname="${hostname}" \
                   --ip-address="$ip_address" \
                   --no_hbac_allow \
                   --setup-dns \
                   --forwarder="$dns_forward_ip" \
                   --reverse-zone="${reverse_zone_name}" \
                   --unattended
