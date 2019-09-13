#!/usr/bin/env bash

# Input variables are:
# cert_pw - the password associated with the PKCS#12 certificate

set -o nounset
set -o errexit
set -o pipefail

# FreeIPA insists that the ENTIRE certificate chain be present, all
# the way back to the self-signed root cert.  Let's Encypt doesn't
# include all that, so we need to grab the missing pieces.
#
# See https://letsencrypt.org/certificates/ for more details.
curl --silent --output /etc/ipa/isrgrootx1.pem \
     https://letsencrypt.org/certs/isrgrootx1.pem.txt
curl --silent --output /etc/ipa/trustid-x3-root.pem \
     https://letsencrypt.org/certs/trustid-x3-root.pem.txt

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
        -passout pass:"${cert_pw}" \
        -certfile /etc/ipa/isrgrootx1.pem \
        -certfile /etc/ipa/trustid-x3-root.pem
