################################################################################
#
# qt6declarative
#
################################################################################

QT6DECLARATIVE_VERSION = $(QT6_VERSION)
QT6DECLARATIVE_SITE = $(QT6_SITE)
QT6DECLARATIVE_SOURCE = qtdeclarative-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6DECLARATIVE_VERSION).tar.xz
QT6DECLARATIVE_INSTALL_STAGING = YES
QT6DECLARATIVE_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools)
QT6DECLARATIVE_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3

QT6DECLARATIVE_DEPENDENCIES = \
	host-ninja \
	qt6base \
	host-qt6declarative

ifeq ($(BR2_PACKAGE_QT6DECLARATIVE_QUICK),y)
	QT6DECLARATIVE_DEPENDENCIES += qt6shadertools
endif

QT6DECLARATIVE_CONF_OPTS += \
	-GNinja \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_TOOLS_BY_DEFAULT=ON \
	-DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=ON \
	-DCMAKE_CROSSCOMPILING=ON

QT6DECLARATIVE_MAKE = ninja
QT6DECLARATIVE_INSTALL_STAGING_OPTS = install
QT6DECLARATIVE_INSTALL_STAGING_ENV = DESTDIR="$(STAGING_DIR)"
QT6DECLARATIVE_INSTALL_TARGET_OPTS = install
QT6DECLARATIVE_INSTALL_TARGET_ENV = DESTDIR="$(TARGET_DIR)"

HOST_QT6DECLARATIVE_DEPENDENCIES = host-ninja host-zlib
HOST_QT6DECLARATIVE_MAKE = ninja
HOST_QT6DECLARATIVE_CONF_OPTS += \
	-GNinja \
	-DBUILD_SHARED_LIBS=OFF \
	-DFEATURE_GUI=ON \
	-DCMAKE_DESTDIR=$(HOST_DIR) \
	-DCMAKE_INSTALL_PREFIX=$(HOST_DIR) \
	-DCMAKE_INSTALL_RPATH=$(HOST_DIR)/lib

$(eval $(cmake-package))
$(eval $(host-cmake-package))
