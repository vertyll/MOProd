#!/bin/sh

# Wait for PostgreSQL to be ready
/usr/local/bin/wait-for-it.sh moprod-postgres:5432 --timeout=60 --strict -- echo "PostgreSQL is up - executing command"

# Check if migrations script is present and run migrations if it is
if npm run | grep -q "migration:run"; then
  echo "Running database migrations"
  npm run migration:run
else
  echo "No migration script found, skipping migrations"
fi

# Start Nest.js application in production mode
npm run start:prod
