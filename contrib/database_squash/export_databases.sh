#!/usr/bin/env bash
# Re-export the world and hotfixes base files from a live, fully-updated
# database. Regenerates sql/base/world/ and sql/base/hotfixes/ as per-table
# files (chunked via split_dump.py to stay under GitHub size limits).
#
# The databases must be freshly populated and up-to-date (see
# database-squash.md). Do NOT pass --skip-comments or --skip-tz-utc to
# mysqldump: split_dump.py relies on the section comment markers and the
# TIME_ZONE conditional footer.
#
# Connection settings (environment variables):
#   MYSQL_HOST (localhost), MYSQL_PORT (3306), MYSQL_USER (trinity),
#   MYSQL_PWD (password, read by the mysql clients themselves)
#   DB_WORLD (world), DB_HOTFIXES (hotfixes)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SPLIT="$REPO_ROOT/contrib/database_squash/split_dump.py"

MYSQL_HOST="${MYSQL_HOST:-localhost}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-trinity}"
CONN=(-h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER")

export_db() {
    local database="$1" dir="$2"
    local out="$REPO_ROOT/sql/base/$dir"

    echo "Exporting database '$database' to $out ..."
    rm -f "$out"/*.sql

    mysqldump "${CONN[@]}" --extended-insert --default-character-set=utf8 \
        "$database" | python3 "$SPLIT" --input - --output-dir "$out"

    local oversized
    oversized=$(find "$out" -name '*.sql' -size +47M)
    if [[ -n "$oversized" ]]; then
        echo "ERROR: files at or above the 50 MB GitHub warning limit:" >&2
        echo "$oversized" >&2
        exit 1
    fi
}

export_db "${DB_WORLD:-world}" world
export_db "${DB_HOTFIXES:-hotfixes}" hotfixes

echo "Done. Review the diff with: git -C $REPO_ROOT status sql/base"
