#!/bin/bash
set -e

DB_NAME="$APP_NAME_$RAILS_ENV"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER bpe;
    ALTER USER bpe WITH PASSWORD 'password';
    CREATE DATABASE bpe_development;
    GRANT ALL PRIVILEGES ON DATABASE bpe_development TO bpe;
EOSQL
