#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

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

	echo "Copying KNoT Overlays files to '/rpi-firmware/overlays/'"
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

for arg in "$@"
do
	case "${arg}" in
		--add-pi3-miniuart-bt-overlay)
		if ! grep -qE '^dtoverlay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# fixes rpi3 ttyAMA0 serial console
dtoverlay=pi3-miniuart-bt
__EOF__
		fi
		;;
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		if ! grep -qE '^arm_64bit=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable 64bits support
arm_64bit=1
__EOF__
		fi

		# Enable uart console
		if ! grep -qE '^enable_uart=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable rpi3 ttyS0 serial console
enable_uart=1
__EOF__
		fi
		;;
		--gpu_mem_256=*|--gpu_mem_512=*|--gpu_mem_1024=*)
		# Set GPU memory
		gpu_mem="${arg:2}"
		sed -e "/^${gpu_mem%=*}=/s,=.*,=${gpu_mem##*=}," -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		;;
	esac

done

rm -rf "${GENIMAGE_TMP}"

# Create a zero filled ext4 file to work as data dir on target
dd if=/dev/zero of="${BINARIES_DIR}/data.ext4" bs=1M count=256
mkfs.ext4 "${BINARIES_DIR}/data.ext4"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
