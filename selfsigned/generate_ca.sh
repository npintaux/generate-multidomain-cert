#!/bin/bash

sudo openssl genrsa -out server.key 2048

sudo openssl req -new -out server.csr -key server.key -config selfsignedca.cnf

sudo openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.crt -extensions v3_req -extfile selfsignedca.cnf

sudo chmod 644 server.key server.crt


