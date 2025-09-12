#!/bin/bash

CERTS_DIR="./certs"

openssl verify -CAfile "$CERTS_DIR/ca.crt" "$CERTS_DIR/server.crt"
openssl verify -CAfile "$CERTS_DIR/ca.crt" "$CERTS_DIR/client.crt"
