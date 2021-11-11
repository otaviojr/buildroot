################################################################################
#
# uvexposure
#
################################################################################

UVEXPOSURE_VERSION = main
UVEXPOSURE_SOURCE = burn-main-br1.tar.gz
UVEXPOSURE_SITE = git://github.com/otaviojr/burn.git
UVEXPOSURE_SITE_METHOD = git
BR_NO_CHECK_HASH_FOR += burn-main-br1.tar.gz
UVEXPOSURE_LICENSE = MIT
UVEXPOSURE_LICENSE_FILES = LICENSE
UVEXPOSURE_DEPENDENCIES = qt6base qt6websockets qt6wayland qt6virtualkeyboard qt6svg qt6declarative qt6qt5compat cairo pango libglib2

UVEXPOSURE_CONF_OPTS += \
	-GNinja \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DCMAKE_CROSSCOMPILING=ON

UVEXPOSURE_MAKE = ninja
UVEXPOSURE_INSTALL_STAGING_OPTS = install
UVEXPOSURE_INSTALL_STAGING_ENV = DESTDIR="$(STAGING_DIR)"
UVEXPOSURE_INSTALL_TARGET_OPTS = install
UVEXPOSURE_INSTALL_TARGET_ENV = DESTDIR="$(TARGET_DIR)"

define UVEXPOSURE_INSTALL_SYSTEMD_SERVICES
	$(INSTALL) -D -m 0755 package/delta3d/uvexposure/cage@tty1.service $(TARGET_DIR)/lib/systemd/system/cage@tty1.service
	$(INSTALL) -D -m 0755 package/delta3d/uvexposure/pamd_cage $(TARGET_DIR)/etc/pam.d/cage
	$(INSTALL) -D -m 0755 package/delta3d/uvexposure/burn.sh $(TARGET_DIR)/app/burn.sh
	$(INSTALL) -D -m 0755 package/delta3d/uvexposure/burn-cli.sh $(TARGET_DIR)/app/burn-cli.sh
	$(INSTALL) -D -m 0755 package/delta3d/uvexposure/99-touch-rules.rules $(TARGET_DIR)/etc/udev/rules.d/99-touch-rules.rules
	[ -d $(TARGET_DIR)/lib/systemd/system/graphical.target.wants ] || mkdir $(TARGET_DIR)/lib/systemd/system/graphical.target.wants
	ln -sf /lib/systemd/system/cage@tty1.service $(TARGET_DIR)/lib/systemd/system/graphical.target.wants/cage@tty1.service
	ln -sf /lib/systemd/system/graphical.target $(TARGET_DIR)/etc/systemd/system/default.target
endef
UVEXPOSURE_POST_INSTALL_TARGET_HOOKS += UVEXPOSURE_INSTALL_SYSTEMD_SERVICES

$(eval $(cmake-package))
