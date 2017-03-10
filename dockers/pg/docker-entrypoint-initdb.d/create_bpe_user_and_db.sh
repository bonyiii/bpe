#!/bin/bash
set -e

DB_NAME="$APP_NAME_$RAILS_ENV"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER bpe;
    CREATE DATABASE bpe_test;
    GRANT ALL PRIVILEGES ON DATABASE bpe_test TO bpe;
EOSQL
