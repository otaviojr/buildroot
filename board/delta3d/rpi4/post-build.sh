#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

cp ${BOARD_DIR}/fstab ${TARGET_DIR}/etc/fstab
