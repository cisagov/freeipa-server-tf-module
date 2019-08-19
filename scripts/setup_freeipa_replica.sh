#!/usr/bin/env bash

# Input variables are:
# admin_pw - the admin password for the IPA server's Kerberos admin
# role
# hostname - the hostname of this IPA replica server
# (e.g. ipa-replica.example.com)
# master_hostname - the hostname of the IPA master server
# (e.g. ipa.example.com)

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

# If the user gave a value for the IPA master hostname then wait until
# the master is up and running before installing.
#
# master_hostname below looks like a shell variable but is actually
# replaced by the Terraform templating engine.  Hence we can ignore
# the "undefined variable" warning from shellcheck.
#
# shellcheck disable=SC2154
if [ "${master_hostname}" != "" ]
then
   until ipa-replica-conncheck --replica="${master_hostname}"
   do
       sleep 60
   done
fi

# There are several items below that look like shell variables but are
# actually replaced by the Terraform templating engine.  Hence we can
# ignore the "undefined variable" warnings from shellcheck.
#
# shellcheck disable=SC2154
ipa-replica-install --setup-ca \
                    --admin-password="${admin_pw}" \
                    --hostname="${hostname}" \
                    --ip-address="$ip_address" \
                    --no-ntp \
                    --unattended
