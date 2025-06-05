#!/bin/bash
set -e

# Check for SSL config and disable if certificates aren't available
if [ ! -f /etc/postgresql/ssl/fullchain.pem ] || [ ! -f /etc/postgresql/ssl/privkey.pem ]; then
  echo "SSL certificates not found, disabling SSL"
  # Modify the postgresql.conf to disable SSL
  sed -i 's/ssl = on/ssl = off/' /etc/postgresql/postgresql.conf
fi

# Then run the original entrypoint
exec docker-entrypoint.sh "$@"