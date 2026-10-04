#!/bin/sh
set -eu
cd "$(dirname "$0")"
set -a; . ./.env; set +a
mkdir -p data/backups
file="data/backups/ghostfolio-$(date +%Y%m%d-%H%M%S).sql.gz"
docker exec gf-postgres pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" | gzip > "$file"
chmod 600 "$file"
ls -1t data/backups/ghostfolio-*.sql.gz | tail -n +31 | xargs -r rm --
echo "$file"
