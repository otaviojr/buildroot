#!/bin/sh

dd if=/dev/sda2 of=/dev/sda3 bs=4096
dd if=/dev/sda5 of=/dev/sda6 bs=4096
[ -d /system-update ] || rm -Rf /system-update
shutdown -r now
