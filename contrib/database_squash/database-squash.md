# Database squash

A *squash* folds the accumulated update files under `sql/updates/` into the
per-table base files under `sql/base/`, so fresh installs apply the base data
plus only a short tail of recent updates. This is the in-repo equivalent of
upstream TrinityCore publishing a new TDB release, and mirrors AzerothCore's
squash process.

Run a squash when `sql/updates/world/master/` (or hotfixes) has grown large
enough to noticeably slow fresh installs — there is no fixed cadence.

## How correctness works

The base files for world and hotfixes include `updates.sql` /
`updates_include.sql`, which seed each database's `updates` tracking table.
An update listed there (state `ARCHIVED`) is never re-applied on a fresh
install. Moving old update files into `sql/old/<version>/` is only
housekeeping; the seed inside the re-exported base files is what prevents
re-application.

## Prerequisites

- `mysql`, `mysqldump`, `python3`, `git` on PATH.
- A MySQL server with the auth/characters/world/hotfixes databases, fully
  populated and up to date (run the worldserver once beforehand).
- A clean git working tree in this repository.
- **No database changes may be merged while the squash is in progress.**

## Procedure

```sh
export MYSQL_USER=trinity MYSQL_PWD=trinity   # adjust to your setup
contrib/database_squash/database_squash.sh
```

The script walks through three steps:

1. **Archive** (`archive_updates.sh`): `git mv`s the files from
   `sql/updates/{world,hotfixes}/master/` to `sql/old/<version>/`, registers
   that directory in `updates_include` (state `ARCHIVED`) and flips the moved
   entries in the `updates` table to `ARCHIVED`. The two-state
   `RELEASED`/`ARCHIVED` model means archived entries are not re-hashed at
   startup (unless `Updates.ArchivedRedundancy = 1`) and do not trip the
   `Updates.CleanDeadRefMaxCount` orphan cleanup.
2. **Repopulate** (manual): drop and recreate the world and hotfixes
   databases, then run the worldserver once so they are rebuilt from the
   current base files plus the not-yet-archived updates. This refreshes the
   `updates` table that step 3 bakes into the new base files.
3. **Export** (`export_databases.sh`): re-dumps both databases through
   `split_dump.py` into `sql/base/world/` and `sql/base/hotfixes/`,
   re-chunking any table over 40 MB and failing if any output file reaches
   50 MB (GitHub's warning limit; the hard limit is 100 MB).

Afterwards, review `git status sql`, commit, and verify by doing a fresh
install from the new base files — it must apply **zero** updates from the
archived set.

## Notes

- `export_databases.sh` deliberately keeps mysqldump's extended (multi-row)
  INSERT format and session comments; `split_dump.py` parses the section
  markers and `TIME_ZONE` conditionals, so do not add `--skip-comments` or
  `--skip-tz-utc`.
- Auth and characters base files (`sql/base/*_database.sql`) are maintained
  by hand and are not part of this process; their update volume is tiny.
- New update files between squashes go to `sql/updates/<db>/master/` with
  unique, lexically increasing names (the updater applies them in sorted
  order and tracks them by filename and SHA1 hash).
