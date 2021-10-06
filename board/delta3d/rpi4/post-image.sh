#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

#copy custom boot files
cp ${BOARD_DIR}/config.txt ${BINARIES_DIR}/rpi-firmware/config.txt
cp ${BOARD_DIR}/cmdline.txt ${BINARIES_DIR}/rpi-firmware/cmdline.txt

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

cp -Rf ${TARGET_DIR}/var ${ROOTPATH_TMP}/var

genimage \
        --rootpath "${ROOTPATH_TMP}"   \
        --tmppath "${GENIMAGE_TMP}"    \
        --inputpath "${BINARIES_DIR}"  \
        --outputpath "${BINARIES_DIR}" \
        --config "${GENIMAGE_CFG}"

cp ${BOARD_DIR}/sw-description ${BINARIES_DIR}
cp ${BOARD_DIR}/sw-update-script.sh ${BINARIES_DIR}

gzip -9 -c -n ${BINARIES_DIR}/boot.vfat > ${BINARIES_DIR}/boot.vfat.gz

IMG_FILES="sw-description boot.vfat.gz rootfs.ext2.gz sw-update-script.sh"

pushd ${BINARIES_DIR}
for f in ${IMG_FILES} ; do
	echo ${f}
done | cpio -ovL -H crc > buildroot.swu
popd

exit $?
