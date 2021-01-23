#!/bin/bash
set -e

echo -e "-- \x1b[32mCreating timescaledb extension\x1b[0m"
$PSQL "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE
