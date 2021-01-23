FROM timescale/timescaledb:latest-pg10

ADD ./scripts/10-create_users.sh /docker-entrypoint-initdb.d/10-create_users.sh
ADD ./scripts/20-create_databases.sh /docker-entrypoint-initdb.d/20-create_databases.sh
