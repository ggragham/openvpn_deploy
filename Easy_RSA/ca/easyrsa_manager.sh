#!/usr/bin/env bash

# Easy-RSA management script.
# Build CA, sign requests, generate clients, revoke certificates, etc.

set -euo pipefail
cd "$(dirname "$0")" || exit "$?"

PKI_PATH="./pki"
REQ_PATH="$PKI_PATH/reqs"

buildCA() {
    if [[ ! -d $PKI_PATH ]]; then
        easyrsa init-pki
        echo "set_var EASYRSA_ALGO ec
set_var EASYRSA_CURVE prime256v1
set_var EASYRSA_REQ_CN $SERVER_NAME" >"$PKI_PATH/vars"
    fi

    if [[ ! -f $PKI_PATH/ca.crt ]]; then
        easyrsa --batch build-ca nopass
    fi
}

signServer() {
    if [[ -f $REQ_PATH/$SERVER_NAME.req ]]; then
        easyrsa --batch sign-req server "$SERVER_NAME"
    else
        exit "$?"
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
    gen_client)
        # TODO
        echo TODO
        touch test.file
        ;;
    revoke_client)
        # TODO
        echo TODO
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
