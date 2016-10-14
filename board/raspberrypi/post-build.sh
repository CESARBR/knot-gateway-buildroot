#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Remove "/var/log" link and make "/var/log" a directory
if [ -h ${TARGET_DIR}/var/log ]; then
	unlink ${TARGET_DIR}/var/log
fi
mkdir -p -m 775 ${TARGET_DIR}/var/log/

# Change hostname
echo "knot" > ${TARGET_DIR}/etc/hostname
