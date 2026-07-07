#!/bin/bash

#
# postroot.sh
# Executed as root after plugin installation
#

# ---------------------------------------------------------------------------
# Plugin arguments
# ---------------------------------------------------------------------------

COMMAND=$0
PTEMPDIR=$1
PSHNAME=$2
PDIR=$3
PVERSION=$4
PTEMPPATH=$6

# ---------------------------------------------------------------------------
# LoxBerry paths
# ---------------------------------------------------------------------------

PCGI=$LBPCGI/$PDIR
PHTML=$LBPHTML/$PDIR
PTEMPL=$LBPTEMPL/$PDIR
PDATA=$LBPDATA/$PDIR
PLOG=$LBPLOG/$PDIR
PCONFIG=$LBPCONFIG/$PDIR
PSBIN=$LBPSBIN/$PDIR
PBIN=$LBPBIN/$PDIR

FHEM_HOME="/opt/fhem"
FHEM_CFG="$FHEM_HOME/fhem.cfg"

# ---------------------------------------------------------------------------
# Check installation
# ---------------------------------------------------------------------------

if ! dpkg -s fhem >/dev/null 2>&1; then
    echo "<ERROR> FHEM package is not installed."
    exit 1
fi

if [ ! -d "$FHEM_HOME" ]; then
    echo "<ERROR> $FHEM_HOME does not exist."
    exit 1
fi

if ! id fhem >/dev/null 2>&1; then
    echo "<ERROR> User 'fhem' does not exist."
    exit 1
fi

# ---------------------------------------------------------------------------
# Migrate old installation
# ---------------------------------------------------------------------------

if [ -f "$PDATA/fhem.pl" ]; then

    echo "<INFO> Found old FHEM installation."
    echo "<INFO> Migrating data..."

    chown -R fhem:dialout "$PDATA"

    cp -an "$PDATA"/. "$FHEM_HOME"/

    mkdir -p "$PDATA/oldinstall"

    find "$PDATA" -mindepth 1 -maxdepth 1 ! -name oldinstall -exec mv {} "$PDATA/oldinstall/" \;

    if [ -f "$PCONFIG/fhem.cfg" ]; then
        cp "$PCONFIG/fhem.cfg" "$FHEM_CFG"
        mv "$PCONFIG/fhem.cfg" "$PCONFIG/fhem.cfg.oldinstall"
    fi

fi

# ---------------------------------------------------------------------------
# Configure FHEM
# ---------------------------------------------------------------------------

if [ -f "$FHEM_CFG" ]; then

    echo "<INFO> Adjusting FHEM configuration..."

    sed -i \
        -e 's:^define initialUsbCheck notify:#define initialUsbCheck notify:g' \
        -e 's:/loxberry/log/plugins/fhem/fhem.log:/fhem/log/fhem-%Y-%m.log:g' \
        -e 's:/loxberry/data/plugins/fhem/fhem.save:/fhem/fhem.save:g' \
        -e 's:/loxberry/log/plugins/fhem/%NAME.log:/fhem/log/%NAME.log:g' \
        -e 's:/loxberry/data/plugins/fhem/eventTypes.txt:/fhem/eventTypes.txt:g' \
        "$FHEM_CFG"

    chown fhem:dialout "$FHEM_CFG"

else
    echo "<WARNING> FHEM configuration not found."
fi

# ---------------------------------------------------------------------------
# Stop old processes
# ---------------------------------------------------------------------------

echo "<INFO> Stopping running FHEM..."

pkill -TERM -f "fhem.pl" >/dev/null 2>&1

sleep 2

pkill -KILL -f "fhem.pl" >/dev/null 2>&1

# ---------------------------------------------------------------------------
# Enable service
# ---------------------------------------------------------------------------

if systemctl list-unit-files | grep -q '^fhem.service'; then

    echo "<INFO> Enabling FHEM service..."

    systemctl daemon-reload
    systemctl enable fhem
    systemctl restart fhem

    echo "<OK> FHEM service started."

else
    echo "<WARNING> fhem.service not found."
fi

exit 0