#!/bin/bash

# From https://docs.docker.com/compose/startup-order/

set -e

# Set environment variables for psql to read
export PGDATABASE=$BESPIN_DB_NAME
export PGPASSWORD=$BESPIN_DB_PASSWORD
export PGUSER=$BESPIN_DB_USER
export PGHOST=$BESPIN_DB_HOST
cmd="$@"

until psql -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
