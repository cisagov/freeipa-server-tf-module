#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

openssl pkcs12 -export \
        -out /etc/ipa/cert.p12 \
        -in /etc/ipa/fullchain.pem \
        -inkey /etc/ipa/privkey.pem \
        -passout pass:zooble
