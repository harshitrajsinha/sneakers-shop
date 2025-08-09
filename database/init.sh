#!/bin/bash
set -e

# Create the databases
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE sneaker_db;
    CREATE DATABASE logs_db;
EOSQL

# Run app_db schema
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname sneaker_db < /docker-entrypoint-initdb.d/init.sql

# Run logs_db schema
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname logs_db < /docker-entrypoint-initdb.d/logs_init.sql
