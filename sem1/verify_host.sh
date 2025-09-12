#!/bin/bash

CERTS_DIR="./certs"

openssl verify -CAfile "$CERTS_DIR/ca.crt" -verify_hostname foo.bar.baz "$CERTS_DIR/server.crt"
