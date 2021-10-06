################################################################################
#
# genimage
#
################################################################################

#GENIMAGE_VERSION = 14
#GENIMAGE_SOURCE = genimage-$(GENIMAGE_VERSION).tar.xz
#GENIMAGE_SITE = https://github.com/pengutronix/genimage/releases/download/v$(GENIMAGE_VERSION)
GENIMAGE_VERSION = 43fccb587082af7d6563a6888ce1ad74c7d2f381
GENIMAGE_SITE = git://github.com/pengutronix/genimage.git
CAGE_SITE_METHOD = git
BR_NO_CHECK_HASH_FOR += genimage-43fccb587082af7d6563a6888ce1ad74c7d2f381-br1.tar.gz
HOST_GENIMAGE_DEPENDENCIES = host-pkgconf host-libconfuse
GENIMAGE_LICENSE = GPL-2.0
GENIMAGE_LICENSE_FILES = COPYING
GENIMAGE_AUTORECONF = YES
$(eval $(host-autotools-package))
