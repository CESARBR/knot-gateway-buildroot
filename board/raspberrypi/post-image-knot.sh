#!/bin/sh

BOARD_DIR="$(dirname $0)"

trim() {
	local target=$1
	while :; do # this is an infinite loop
		case $target in
		' '*)
			target=${target#?};; ## if $target begins with a space remove it
		*' ')
			target=${target%?};; ## if $target ends with a space remove it
		*)
			break;; # no more leading or trailing spaces, so exit the loop
		esac
	done
	dtbo=$target
}

#Check whether DTB Overlays have been installed
if  test -d "${BINARIES_DIR}/rpi-firmware/overlays/" ; then

	echo Copying KNoT Overlays files to '/rpi-firmware/overlays/'
	cp -u "${BOARD_DIR}/knot_overlays"/*.dtbo "${BINARIES_DIR}/rpi-firmware/overlays/"

	while test -n "$2"; do
		if [ `expr substr $2 1 6` = "--add-" ]; then
			dtbo=${2#*--add-}
			dtbo=${dtbo%-overlay*}
			trim ${dtbo}
			if ! grep -qE "^dtoverlay=$dtbo" "${BINARIES_DIR}/rpi-firmware/config.txt"; then
				echo "Adding 'dtoverlay=$dtbo' to config.txt"
				cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# fixes $2
dtoverlay=${dtbo}
__EOF__
			fi
		fi
		shift
	done
fi
