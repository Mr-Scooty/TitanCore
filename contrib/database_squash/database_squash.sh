#!/usr/bin/env bash
# Interactive database squash: fold the accumulated sql/updates/ files of the
# world and hotfixes databases into the per-table base files under sql/base/.
# Read database-squash.md before running this.
#
# Connection: MYSQL_HOST (localhost), MYSQL_PORT (3306), MYSQL_USER (trinity),
# MYSQL_PWD (password), DB_WORLD (world), DB_HOTFIXES (hotfixes).

set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$HERE/../.." && pwd)"
DB_WORLD="${DB_WORLD:-world}"
DB_HOTFIXES="${DB_HOTFIXES:-hotfixes}"

read -r -p "Archive version label for the moved updates (e.g. 7.3.5-2026-06): " VERSION
[[ -n "$VERSION" ]] || { echo "A version label is required." >&2; exit 1; }

cat <<EOF

This will:
  1. git mv sql/updates/{world,hotfixes}/master/*.sql to sql/old/$VERSION/
     and mark them ARCHIVED in '$DB_WORLD' / '$DB_HOTFIXES'.
  2. Ask you to drop and repopulate both databases with the worldserver.
  3. Re-export sql/base/world/ and sql/base/hotfixes/ from the live databases.

Make sure no database changes are merged while the squash is in progress.
EOF
read -r -p "Continue? [y/N] " answer
[[ "$answer" == [yY] ]] || exit 1

"$HERE/archive_updates.sh" --db "$DB_WORLD"    --dbdir world    --archive-version "$VERSION"
"$HERE/archive_updates.sh" --db "$DB_HOTFIXES" --dbdir hotfixes --archive-version "$VERSION"

cat <<EOF

Now drop and repopulate both databases so the base export is clean:

  mysql> DROP DATABASE $DB_WORLD; DROP DATABASE $DB_HOTFIXES;
  mysql> CREATE DATABASE $DB_WORLD DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
  mysql> CREATE DATABASE $DB_HOTFIXES DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

Then run the worldserver once with Updates.AutoSetup = 1 and let it finish
populating and applying the remaining (non-archived) updates, then stop it.
EOF
read -r -p "Databases repopulated and worldserver stopped? [y/N] " answer
[[ "$answer" == [yY] ]] || { echo "Aborted before export; the archive step is already committed to the working tree." >&2; exit 1; }

"$HERE/export_databases.sh"

cat <<EOF

Squash complete. Review and commit:
  git -C $REPO_ROOT status sql
Then verify with a fresh install from the new base files (expect 0 updates applied).
EOF
