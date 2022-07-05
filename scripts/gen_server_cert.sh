#!/usr/bin/env bash

# Script to enerate certificate request for server.

set -euo pipefail
cd "$EASY_RSA_PATH" || exit "$?"

genPKI() {
    easyrsa init-pki
    echo "set_var EASYRSA_ALGO ec
set_var EASYRSA_CURVE prime256v1
set_var EASYRSA_REQ_CN $SERVER_NAME" >pki/vars
}

genCertReq() {
    easyrsa --batch gen-req "$SERVER_NAME" nopass
}

main() {
    if [[ -d $PKI_PATH ]]; then
        if [[ -f $PKI_PATH/issued/$SERVER_NAME.crt ]]; then
            echo "Certificate exist. Skipping..."
            exit 42
        elif [[ -f $PKI_PATH/reqs/$SERVER_NAME.req ]]; then
            echo "Send $SERVER_NAME.req to CA"
            exit 0
        else
            genCertReq
            exit 0
        fi
    else
        genPKI
        genCertReq
        exit 0
    fi
}

main
