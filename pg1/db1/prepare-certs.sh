#!/bin/bash
# Ensure the certificate files exist and have correct permissions
if [ -f /etc/postgresql/ssl/fullchain.pem ] && [ -f /etc/postgresql/ssl/privkey.pem ]; then
  # Fix permissions
  chmod 600 /etc/postgresql/ssl/privkey.pem
  chown postgres:postgres /etc/postgresql/ssl/privkey.pem /etc/postgresql/ssl/fullchain.pem
  echo "SSL certificates prepared successfully"
else
  echo "Warning: SSL certificate files not found"
fi