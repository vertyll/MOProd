#!/bin/sh
# Wait for PostgreSQL to be ready
/usr/local/bin/wait-for-it.sh ${DB_HOST}:${DB_PORT} --timeout=60 --strict -- echo "PostgreSQL is up - executing command"

# Run backend migrations if the script exists
if [ -f "./apps/backend/node_modules/.bin/typeorm" ]; then
  echo "Running database migrations"
  cd ./apps/backend && ../node_modules/.bin/typeorm migration:run && cd ../..
else
  echo "No migration script found, skipping migrations"
fi

# Start the applications
exec "$@"
