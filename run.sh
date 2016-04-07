#!/bin/bash

databaseName=${PSQL_NEW_DB_NAME}
password=${PSQL_NEW_DB_PASSWORD}

if [[ -z "$databaseName" ]]; then
  echo "missing PSQL_NEW_DB_NAME env variable"
  exit 2
fi

if [[ -z "$password" ]]; then
  echo "missing PSQL_NEW_DB_PASSWORD env variable"
  exit 2
fi

cat > create.sql << EOF

CREATE ROLE ${databaseName} with LOGIN PASSWORD '${password}';
GRANT ${databaseName} TO ${PGUSER};

CREATE DATABASE ${databaseName} with OWNER ${databaseName} ENCODING 'UTF8';
REVOKE ${databaseName} FROM ${PGUSER};
EOF

exec psql -f create.sql