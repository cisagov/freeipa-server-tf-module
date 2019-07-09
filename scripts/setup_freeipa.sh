#!/usr/bin/env bash

# Input variables are:
# admin_pw - the admin password for the IPA server's Kerberos admin
# role
# directory_service_pw - the password for the IPA server's directory
# service
# domain - the domain for the IPA server (e.g. example.com)
# hostname - the hostname of the IPA server (e.g. ipa.example.com)
# dns_forwarder - An IP address where the IPA server should forward
# DNS queries that it cannpt answer (e.g. 8.8.8.8)
# realm - the realm for the IPA server (e.g. EXAMPLE.COM)

set -o nounset
set -o errexit
set -o pipefail

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
                   --ip-address="${ip_address}" \
                   --setup-dns \
                   --forwarder="${dns_forwarder}" \
                   --debug \
                   --unattended
