#!/bin/bash

#
# FHEM Plugin - preroot.sh
# Executed as root before plugin installation
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

# ---------------------------------------------------------------------------
# Add FHEM repository
# ---------------------------------------------------------------------------

echo "<INFO> Adding FHEM Repository..."

mkdir -p /etc/apt/keyrings

# Install repository key only if it doesn't already exist
if [ ! -f /etc/apt/keyrings/fhem.gpg ]; then

    echo "<INFO> Downloading FHEM repository key..."

    if ! curl -fsSL https://debian.fhem.de/archive.key \
        | gpg --dearmor -o /etc/apt/keyrings/fhem.gpg; then

        echo "<ERROR> Failed to install FHEM repository key."
        exit 1
    fi

    chmod 644 /etc/apt/keyrings/fhem.gpg
fi

# Configure repository
cat >/etc/apt/sources.list.d/fhem.list <<EOF
deb [signed-by=/etc/apt/keyrings/fhem.gpg] https://debian.fhem.de/nightly/ /
EOF

# ---------------------------------------------------------------------------
# Update package lists
# ---------------------------------------------------------------------------

echo "<INFO> Updating apt databases..."

if ! apt-get -q -y update; then
    echo "<ERROR> apt update failed."
    exit 1
fi

# ---------------------------------------------------------------------------
# Stop running FHEM instance
# ---------------------------------------------------------------------------

if pgrep -f fhem >/dev/null 2>&1; then

    echo "<INFO> Stopping running FHEM..."

    pkill -TERM -f fhem
    sleep 2

    if pgrep -f fhem >/dev/null 2>&1; then
        echo "<WARNING> FHEM still running - forcing shutdown..."
        pkill -KILL -f fhem
    fi
fi

echo "<OK> FHEM repository successfully configured."

exit 0