#!/bin/sh

do_preinst()
{
    exit 0
}

do_postinst()
{
  [ -d /var/lib/system-update ] || mkdir /var/lib/system-update
  ln -s /var/lib/system-update /system-update
  shutdown -r now
  exit 0
}

echo $0 $1 > /dev/ttyO0

case "$1" in
preinst)
    echo "call do_preinst"
    do_preinst
    ;;
postinst)
    echo "call do_postinst"
    do_postinst
    ;;
*)
    echo "default"
    exit 1
    ;;
esac
