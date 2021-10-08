#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

#Offline system update configuration
#cp ${BOARD_DIR}/fstab ${TARGET_DIR}/etc/fstab
#cp ${BOARD_DIR}/system-update.sh ${TARGET_DIR}/usr/bin/system-update.sh
#chmod 755 ${TARGET_DIR}/usr/bin/system-update.sh
#cp ${BOARD_DIR}/system-update.service ${TARGET_DIR}/lib/systemd/system/system-update.service
#[ -d ${TARGET_DIR}/usr/lib/systemd/system/system-update.target.wants ] || mkdir ${TARGET_DIR}/usr/lib/systemd/system/system-update.target.wants
#cp ${BOARD_DIR}/99-udisk2.rules ${TARGET_DIR}/etc/udev/rules.d/99-udisk2.rules
#cp ${BOARD_DIR}/99-automount.rules ${TARGET_DIR}/etc/udev/rules.d/99-automount.rules
#cp ${BOARD_DIR}/automount@.service ${TARGET_DIR}/lib/systemd/system/automount@.service
#cp ${BOARD_DIR}/automount.sh ${TARGET_DIR}/usr/bin/automount.sh

ln -sf /lib/systemd/system/system-update.service ${TARGET_DIR}/usr/lib/systemd/system/system-update.target.wants/system-update.service
