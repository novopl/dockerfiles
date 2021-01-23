#!/bin/bash
set -e

PSQL="psql --username ${POSTGRES_USER}"

function create_user() {
local db_user=$1
local db_pass=$2

echo -e "-- \x1b[32mCreating database role: \x1b[33m${db_user}\x1b[0m"
$PSQL <<-EOSQL
    CREATE USER ${db_user} WITH CREATEDB PASSWORD '${db_pass}';
EOSQL
}


create_user sensei sensei;
