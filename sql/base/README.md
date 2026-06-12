# Base database files

All data needed to populate the databases lives in this repository — no TDB
download is required. On first start, the worldserver auto-populates any empty
database (`Updates.AutoSetup = 1`) and then applies everything under
`sql/updates/` that is not already recorded in that database's `updates` table.

## Layout

| Path                          | Database   | Format |
|-------------------------------|------------|--------|
| `auth_database.sql`           | auth       | single file |
| `characters_database.sql`     | characters | single file |
| `world/`                      | world      | one file per table |
| `hotfixes/`                   | hotfixes   | one file per table |

The per-table directories are applied in byte-wise sorted filename order.

## Chunked tables (`_pNN` files)

Tables whose dump exceeds 40 MB are split to stay under GitHub's 50 MB
warning / 100 MB hard limit:

- `<table>.sql` — structure plus the first slice of data
- `<table>_p01.sql`, `<table>_p02.sql`, … — additional data-only slices

`.` sorts before `_`, so the structure file is always applied before its part
files. Every file is self-contained (carries the mysqldump session header and
footer) and can be re-applied individually.

The `world/updates.sql` and `hotfixes/updates.sql` files seed the `updates`
tracking table, which is what prevents already-folded updates from being
re-applied on a fresh install.

## Requirements

The MySQL **server** must accept packets of at least ~2 MB
(`max_allowed_packet`); the dumps use extended INSERT lines of up to ~1 MB.
MySQL 5.7+ defaults (4 MB or more) are fine. The client side is already
handled by the updater (`--max-allowed-packet=1GB`).

## Regenerating these files

Maintainers fold accumulated `sql/updates/` files into the base data with the
squash tooling in `contrib/database_squash/` — see
`contrib/database_squash/database-squash.md`.
