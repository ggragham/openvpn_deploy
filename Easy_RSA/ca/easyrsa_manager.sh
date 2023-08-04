#!/usr/bin/env bash

# Easy-RSA management script.
# Build CA, sign requests, generate clients, revoke certificates, etc.

# Env vars
# SERVER_NAME
# CLIENT_NAME

set -euo pipefail
cd "$(dirname "$0")" || exit "$?"

PKI_PATH="./pki"
REQ_PATH="$PKI_PATH/reqs"
CERT_PATH="$PKI_PATH/issued"

buildCA() {
    if [[ ! -d $PKI_PATH ]]; then
        easyrsa init-pki
        echo "set_var EASYRSA_ALGO ec
set_var EASYRSA_CURVE prime256v1
set_var EASYRSA_PKI \$PWD/pki" >"$PKI_PATH/vars"
    fi

    if [[ ! -f $PKI_PATH/ca.crt ]]; then
        easyrsa --batch build-ca nopass
    fi
}

signServer() {
    if [[ -f $CERT_PATH/$SERVER_NAME.crt ]]; then
        echo "Certificate exist"
        exit 42
    elif [[ -f $REQ_PATH/$SERVER_NAME.req ]]; then
        easyrsa --batch sign-req server "$SERVER_NAME"
    else
        exit "$?"
    fi
}

checkClientExistence() {
    clientExist=$(grep -c "/CN=$CLIENT_NAME\$" pki/index.txt)

    if [[ $clientExist == 1 ]]; then
        return 0
    else
        return 1
    fi
}

genClient() {
    if checkClientExistence; then
        echo "Client exist"
        exit 42
    else
        easyrsa --batch build-client-full "$CLIENT_NAME" nopass
    fi
}

genCRL() {
    easyrsa gen-crl
}

revokeClient() {
    if checkClientExistence; then
        easyrsa --batch revoke "$CLIENT_NAME"
        genCRL
    else
        echo "Client not exist"
        exit 43
    fi
}

main() {
    local arg="$1"

    case "$arg" in
    build_ca)
        buildCA
        ;;
    sign_server)
        signServer
        ;;
    gen_crl)
        genCRL
        ;;
    gen_client)
        genClient
        ;;
    revoke_client)
        revokeClient
        ;;
    debug)
        bash
        ;;
    exit)
        exit 0
        ;;
    *)
        echo "Invalid option: $arg"
        ;;
    esac
}

main "$1"
