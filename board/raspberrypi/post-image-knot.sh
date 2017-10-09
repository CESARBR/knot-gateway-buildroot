#!/bin/sh

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
