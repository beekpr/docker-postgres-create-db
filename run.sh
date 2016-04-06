#!/bin/bash

databaseName=${PSQL_NEW_DB_NAME}
password=${PSQL_NEW_DB_PASSWORD}

cat > create.sql << EOF
CREATE ROLE ${databaseName} with LOGIN PASSWORD '${password}';
GRANT ${databaseName} TO master

CREATE DATABASE ${databaseName} with OWNER ${databaseName} ENCODING 'UTF8';
REVOKE ${databaseName} FROM master
EOF

exec psql -f create.sql