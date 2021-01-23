#!/bin/bash
set -e

PSQL="psql --username ${POSTGRES_USER}"

function create_database() {
local db_owner=$1
local db_name=$2

echo -e "-- \x1b[32mCreating database \x1b[33m${db_name} \x1b[32mowned by \x1b[33m${db_owner}\x1b[0m"
$PSQL <<-EOSQL
    CREATE DATABASE ${db_name} WITH OWNER '${db_owner}';
EOSQL
}


create_database sensei api
create_database sensei dashboard
create_database sensei auth
