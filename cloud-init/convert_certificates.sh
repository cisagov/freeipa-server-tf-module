#!/usr/bin/env bash

# Input variables are:
# cert_pw - the password associated with the PKCS#12 certificate

set -o nounset
set -o errexit
set -o pipefail

# Grab some root certificates for Let's Encrypt that we will need when
# we install FreeIPA
curl -o /etc/ipa/isrgrootx1.pem \
     https://letsencrypt.org/certs/isrgrootx1.pem.txt
curl -o /etc/ipa/letsencryptauthorityx3.pem \
     https://letsencrypt.org/certs/letsencryptauthorityx3.pem.txt

# Convert the PEMs to PKCS#12 format
#
# The "${cert_pw}" item below that looks like a shell variable but is
# actually replaced by the Terraform templating engine.  Hence we can
# ignore the "undefined variable" warnings from shellcheck.
#
# shellcheck disable=SC2154
openssl pkcs12 -export \
        -out /etc/ipa/cert.p12 \
        -in /etc/ipa/fullchain.pem \
        -inkey /etc/ipa/privkey.pem \
        -passout pass:"${cert_pw}"
