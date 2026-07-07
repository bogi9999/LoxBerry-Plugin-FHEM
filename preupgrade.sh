#!/bin/sh

#
# preupgrade.sh
# Backup existing plugin data before upgrade
#

ARGV0="$0"
ARGV1="$1"
ARGV2="$2"
ARGV3="$3"
ARGV4="$4"
ARGV5="$5"

BACKUP="/tmp/${ARGV1}_upgrade"

echo "<INFO> Creating temporary folders for upgrading"

mkdir -p "$BACKUP/config"
mkdir -p "$BACKUP/log"
mkdir -p "$BACKUP/data"

backup_dir() {
    SRC="$1"
    DST="$2"

    if [ -d "$SRC" ]; then
        echo "<INFO> Backing up $(basename "$SRC")"
        cp -a "$SRC" "$DST"
    else
        echo "<INFO> No existing $(basename "$SRC") directory found."
    fi
}

backup_dir "$ARGV5/config/plugins/$ARGV3" "$BACKUP/config"
backup_dir "$ARGV5/data/plugins/$ARGV3"   "$BACKUP/data"
backup_dir "$ARGV5/log/plugins/$ARGV3"    "$BACKUP/log"

echo "<OK> Backup completed."

exit 0