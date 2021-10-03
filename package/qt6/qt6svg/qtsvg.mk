################################################################################
#
# qt6svg
#
################################################################################

QT6SVG_VERSION = $(QT6_VERSION)
QT6SVG_SITE = $(QT6_SITE)
QT6SVG_SOURCE = qtsvg-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6SVG_VERSION).tar.xz
QT6SVG_INSTALL_STAGING = YES
QT6SVG_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools)
QT6SVG_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3

QT6SVG_CONF_OPTS += \
	-GNinja \
	-DQT_HOST_PATH=$(HOST_DIR) \

QT6SVG_MAKE = ninja
QT6SVG_INSTALL_STAGING_OPTS = install
QT6SVG_INSTALL_STAGING_ENV = DESTDIR="$(STAGING_DIR)"
QT6SVG_INSTALL_TARGET_OPTS = install
QT6SVG_INSTALL_TARGET_ENV = DESTDIR="$(TARGET_DIR)"

$(eval $(cmake-package))
