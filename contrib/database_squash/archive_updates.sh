#!/usr/bin/env bash
# Archive the applied updates of one database: move sql/updates/<dbdir>/master
# files into sql/old/<version>/<dbdir> and mark them ARCHIVED in the live
# database, so the subsequent base-file export seeds them as ARCHIVED and
# fresh installs never re-apply them.
#
# Usage:
#   archive_updates.sh --db <mysql database> --dbdir <world|hotfixes|auth|characters> --archive-version <e.g. 7.3.5>
#
# Connection: MYSQL_HOST (localhost), MYSQL_PORT (3306), MYSQL_USER (trinity),
# MYSQL_PWD (password, read by the mysql client itself).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

DATABASE="" DBDIR="" VERSION=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --db)              DATABASE="$2"; shift 2 ;;
        --dbdir)           DBDIR="$2"; shift 2 ;;
        --archive-version) VERSION="$2"; shift 2 ;;
        *) echo "Unknown argument: $1" >&2; exit 1 ;;
    esac
done
if [[ -z "$DATABASE" || -z "$DBDIR" || -z "$VERSION" ]]; then
    echo "Usage: $0 --db <database> --dbdir <world|hotfixes|auth|characters> --archive-version <version>" >&2
    exit 1
fi

MYSQL_HOST="${MYSQL_HOST:-localhost}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-trinity}"
mysql_exec() {
    mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" "$DATABASE" -e "$1"
}

SRC="$REPO_ROOT/sql/updates/$DBDIR/master"
DEST="$REPO_ROOT/sql/old/$VERSION/$DBDIR"

shopt -s nullglob
files=("$SRC"/*.sql)
if [[ ${#files[@]} -eq 0 ]]; then
    echo "No updates to archive in $SRC"
    exit 0
fi

echo "Archiving ${#files[@]} updates from $SRC to $DEST ..."
mkdir -p "$DEST"
names=()
for file in "${files[@]}"; do
    git -C "$REPO_ROOT" mv "$file" "$DEST/"
    names+=("'$(basename "$file")'")
done

name_list=$(IFS=,; echo "${names[*]}")
mysql_exec "INSERT IGNORE INTO updates_include (path, state) VALUES ('\$/sql/old/$VERSION/$DBDIR', 'ARCHIVED');"
mysql_exec "UPDATE updates SET state = 'ARCHIVED' WHERE name IN ($name_list);"

echo "Done. ${#files[@]} updates archived and marked ARCHIVED in '$DATABASE'."
