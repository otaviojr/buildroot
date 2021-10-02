################################################################################
#
# qt6websockets
#
################################################################################

QT6WEBSOCKETS_VERSION = $(QT6_VERSION)
QT6WEBSOCKETS_SITE = $(QT6_SITE)
QT6WEBSOCKETS_SOURCE = qtwebsockets-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6WEBSOCKETS_VERSION).tar.xz
QT6WEBSOCKETS_INSTALL_STAGING = YES
QT6WEBSOCKETS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools)
QT6WEBSOCKETS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3

ifeq ($(BR2_PACKAGE_QT6BASE_EXAMPLES),y)
QT6WEBSOCKETS_LICENSE += , BSD-3-Clause (examples)
endif

$(eval $(qmake-package))
