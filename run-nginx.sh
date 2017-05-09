#!/usr/bin/env bash

# Substitute environment variables
export DOLLAR='$'
envsubst < /nginx.conf.template > /etc/nginx/nginx.conf

# Create chained certificate
cat server.crt server-ca.crt > server.chained.crt

# Run nginx
nginx -g "daemon off;"