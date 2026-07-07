#!/bin/sh

#
# postupgrade.sh
# Restore plugin data after successful upgrade
#

COMMAND="$0"
PTEMPDIR="$1"
PSHNAME="$2"
PDIR="$3"
PVERSION="$4"
LBHOMEDIR="$5"

BACKUP="/tmp/${PTEMPDIR}_upgrade"

restore_dir() {
    SRC="$1"
    DST="$2"

    if [ -d "$SRC" ]; then
        echo "<INFO> Restoring $(basename "$SRC")"
        cp -a "$SRC" "$DST"
    else
        echo "<INFO> No backup for $(basename "$SRC") found."
    fi
}

echo "<INFO> Restoring plugin data..."

restore_dir "$BACKUP/config/$PDIR" "$LBHOMEDIR/config/plugins/"
restore_dir "$BACKUP/data/$PDIR"   "$LBHOMEDIR/data/plugins/"
restore_dir "$BACKUP/log/$PDIR"    "$LBHOMEDIR/log/plugins/"

echo "<INFO> Removing temporary backup"

rm -rf "$BACKUP"

echo "<OK> Upgrade completed."

exit 0