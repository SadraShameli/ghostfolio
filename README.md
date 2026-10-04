# Ghostfolio (self-hosted)

Runs the official `ghostfolio/ghostfolio` image with Postgres 18 and Redis via Docker Compose.

## First setup

```sh
cp .env.example .env   # fill in the placeholders with random strings (openssl rand -hex 32)
docker compose up -d
```

Open <http://localhost:3333> and sign in with the security token in `data/security_token`.

## Update

```sh
docker compose pull && docker compose up -d
```

`postgres:18-alpine` is pinned to its major version on purpose: moving to the next major version needs a dump and restore.

## Backup and restore

```sh
./backup.sh                                        # writes data/backups/ghostfolio-<timestamp>.sql.gz, keeps the last 30
gunzip -c data/backups/<file>.sql.gz | docker exec -i gf-postgres psql -U user -d ghostfolio-db
```

## Files

- `.env`: secrets (git-ignored); `.env.example` lists the keys.
- `data/`: tokens and backups (git-ignored).
  - `security_token`: login.
  - `mcp_token`: read-only MCP access used by Claude Code.
  - `jwt`: API token used for scripted setup.
