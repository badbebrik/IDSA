#!/bin/bash

CERTS_DIR="./certs"


openssl genrsa -out "$CERTS_DIR/ca.key" 4096
openssl req -x509 -new -nodes -key "$CERTS_DIR/ca.key" -sha256 -days 3650 \
  -out "$CERTS_DIR/ca.crt" \
  -subj "/CN=MyRootCA"

cat > "$CERTS_DIR/server.cnf" <<'EOF'
[req]
distinguished_name = dn
req_extensions = req_ext
prompt = no

[dn]
CN = foo.bar.baz

[req_ext]
subjectAltName = @alt_names
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[alt_names]
DNS.1 = foo.bar.baz
EOF

openssl genrsa -out "$CERTS_DIR/server.key" 2048
openssl req -new -key "$CERTS_DIR/server.key" -out "$CERTS_DIR/server.csr" -config "$CERTS_DIR/server.cnf"
openssl x509 -req -in "$CERTS_DIR/server.csr" -CA "$CERTS_DIR/ca.crt" -CAkey "$CERTS_DIR/ca.key" -CAcreateserial \
  -out "$CERTS_DIR/server.crt" -days 365 -sha256 -extfile "$CERTS_DIR/server.cnf" -extensions req_ext

cat > "$CERTS_DIR/client.cnf" <<'EOF'
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
EOF

openssl genrsa -out "$CERTS_DIR/client.key" 2048
openssl req -new -key "$CERTS_DIR/client.key" -out "$CERTS_DIR/client.csr" \
  -subj "/CN=TestClient"
openssl x509 -req -in "$CERTS_DIR/client.csr" -CA "$CERTS_DIR/ca.crt" -CAkey "$CERTS_DIR/ca.key" -CAcreateserial \
  -out "$CERTS_DIR/client.crt" -days 365 -sha256 -extfile "$CERTS_DIR/client.cnf"

openssl verify -CAfile "$CERTS_DIR/ca.crt" "$CERTS_DIR/server.crt"
openssl verify -CAfile "$CERTS_DIR/ca.crt" "$CERTS_DIR/client.crt"

