#!/usr/bin/env bash

# Input variables are:
# admin_pw - the admin password for the IPA server's Kerberos admin
# role
# cert_pw - the password associated with the PKCS#12 certificate
# directory_service_pw - the password for the IPA server's directory
# service
# domain - the domain for the IPA server (e.g. example.com)
# hostname - the hostname of the IPA server (e.g. ipa.example.com)
# realm - the realm for the IPA server (e.g. EXAMPLE.COM)

set -o nounset
set -o errexit
set -o pipefail

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

ip_address=$(get_ip eth0)

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
                   --http-cert-file=/etc/ipa/cert.p12 \
                   --http-pin="${cert_pw}" \
                   --dirsrv-cert-file=/etc/ipa/cert.p12 \
                   --dirsrv-pin="${cert_pw}" \
                   --no-ntp \
                   --no-pkinit \
                   --no_hbac_allow \
                   --unattended
