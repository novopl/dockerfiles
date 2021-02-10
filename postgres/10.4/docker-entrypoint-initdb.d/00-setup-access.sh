#!/bin/bash

echo "=== Current pg_hba.conf ========================================"
cat "$PGDATA/pg_hba.conf"

echo "=== Writing pg_hba.conf ========================================"
cat > "$PGDATA/pg_hba.conf" <<'__END__'
# Allow only SSL connections
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local       all         all                                     trust
hostssl     all         all             all                     md5
hostnossl   all         all             all                     reject
__END__

cat "$PGDATA/pg_hba.conf"
