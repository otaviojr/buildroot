################################################################################
#
# qt6base
#
################################################################################

QT6BASE_VERSION = $(QT6_VERSION)
QT6BASE_SITE = $(QT6_SITE)
QT6BASE_SOURCE = qtbase-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6BASE_VERSION).tar.xz

QT6BASE_DEPENDENCIES = \
	host-pkgconf \
	host-ninja \
	host-qt6base \
	libb2 \
	pcre2 \
	zlib \
	double-conversion

QT6BASE_INSTALL_STAGING = YES
QT6BASE_SUPPORTS_IN_SOURCE_BUILD = NO

QT6BASE_MAKE = ninja
QT6BASE_INSTALL_STAGING_OPTS = install
QT6BASE_INSTALL_STAGING_ENV = DESTDIR="$(STAGING_DIR)"
QT6BASE_INSTALL_TARGET_OPTS = install
QT6BASE_INSTALL_TARGET_ENV = DESTDIR="$(TARGET_DIR)"

QT6BASE_CONF_OPTS += \
	-GNinja \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_WITH_PCH=OFF \
	-DFEATURE_animation=OFF \
	-DFEATURE_concurrent=OFF \
	-DFEATURE_doubleconversion=ON \
	-DFEATURE_easingcurve=OFF \
	-DFEATURE_hijricalendar=OFF \
	-DFEATURE_islamiccivilcalendar=OFF \
	-DFEATURE_jalalicalendar=OFF \
	-DFEATURE_libudev=ON \
	-DFEATURE_mimetype=ON \
	-DFEATURE_mimetype_database=ON \
	-DFEATURE_precompile_header=OFF \
	-DFEATURE_sql=OFF \
	-DFEATURE_system_doubleconversion=ON \
	-DFEATURE_system_libb2=ON \
	-DFEATURE_system_pcre2=ON \
	-DFEATURE_system_zlib=ON \
	-DFEATURE_testlib=OFF \
	-DFEATURE_translation=OFF \
	-DINSTALL_DESCRIPTIONSDIR=/usr/lib/qt6/modules \
	-DINSTALL_DOCDIR=/usr/lib/qt6/doc \
	-DINSTALL_EXAMPLESDIR=/usr/lib/qt6/examples \
	-DINSTALL_MKSPECSDIR=/usr/lib/qt6/mkspecs \
	-DINSTALL_PLUGINSDIR=/usr/lib/qt6/plugins \
	-DINSTALL_QMLDIR=/usr/lib/qt6/qml \
	-DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF \
	-DQT_BUILD_TESTS_BY_DEFAULT=OFF \
	-DQT_BUILD_TOOLS_BY_DEFAULT=OFF \
	-DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING=OFF \
	-DQT_QMAKE_TARGET_MKSPEC=linux-g++ \
	-DQT_USE_BUNDLED_BundledFreetype=OFF \
	-DQT_USE_BUNDLED_BundledLibpng=OFF \
	-DQT_USE_BUNDLED_BundledPcre2=OFF \
	-DECM_ENABLE_SANITIZERS=OFF


#	-DFEATURE_glib=ON
#	-DFEATURE_glibc=OFF

#ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_90620),y)
#QT6BASE_CFLAGS += -O0
#QT6BASE_CXXFLAGS += -O0
#endif
#
QT6BASE_CONF_OPTS += -DFEATURE_sse2=$(if $(BR2_X86_CPU_HAS_SSE2),ON,OFF)
QT6BASE_CONF_OPTS += -DFEATURE_sse3=$(if $(BR2_X86_CPU_HAS_SSE3),ON,OFF)
QT6BASE_CONF_OPTS += -DFEATURE_sse4_1=$(if $(BR2_X86_CPU_HAS_SSE4),ON,OFF)
QT6BASE_CONF_OPTS += -DFEATURE_sse4_2=$(if $(BR2_X86_CPU_HAS_SSE42),ON,OFF)
QT6BASE_CONF_OPTS += -DFEATURE_ssse3=$(if $(BR2_X86_CPU_HAS_SSSE3),ON,OFF)
QT6BASE_CONF_OPTS += -DFEATURE_avx=$(if $(BR2_X86_CPU_HAS_AVX),ON,OFF)
QT6BASE_CONF_OPTS += -DFEATURE_avx2=$(if $(BR2_X86_CPU_HAS_AVX2),ON,OFF)
# no buildroot BR2_X86_CPU_HAS_AVX512 option yet
QT6BASE_CONF_OPTS += \
	-DFEATURE_avx512bw=OFF \
	-DFEATURE_avx512cd=OFF \
	-DFEATURE_avx512dq=OFF \
	-DFEATURE_avx512er=OFF \
	-DFEATURE_avx512f=OFF \
	-DFEATURE_avx512ifma=OFF \
	-DFEATURE_avx512pf=OFF \
	-DFEATURE_avx512vbmi=OFF \
	-DFEATURE_avx512vl=OFF

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_LIBDRM),y)
QT6BASE_CONF_OPTS += -DFEATURE_kms=ON
QT6BASE_DEPENDENCIES += libdrm
else
QT6BASE_CONF_OPTS += -DFEATURE_kms=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
# Uses libgbm from mesa3d
ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_EGL),y)
QT6BASE_CONF_OPTS += -DFEATURE_gbm=ON
QT6BASE_DEPENDENCIES += mesa3d
else ifeq ($(BR2_PACKAGE_GCNANO_BINARIES),y)
QT6BASE_CONF_OPTS += -DFEATURE_gbm=ON
QT6BASE_DEPENDENCIES += gcnano-binaries
else ifeq ($(BR2_PACKAGE_TI_SGX_LIBGBM),y)
QT6BASE_CONF_OPTS += -DFEATURE_gbm=ON
QT6BASE_DEPENDENCIES += ti-sgx-libgbm
else ifeq ($(BR2_PACKAGE_IMX_GPU_VIV_OUTPUT_WL),y)
QT6BASE_CONF_OPTS += -DFEATURE_gbm=ON
QT6BASE_DEPENDENCIES += imx-gpu-viv
else
QT6BASE_CONF_OPTS += -DFEATURE_gbm=OFF
endif

#ifeq ($(BR2_ENABLE_DEBUG),y)
#QT6BASE_CONFIGURE_OPTS += -debug
#else
#QT6BASE_CONFIGURE_OPTS += -release
#endif
#
#QT6BASE_CONFIGURE_OPTS += -opensource -confirm-license
#QT6BASE_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
#QT6BASE_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPLv3 LICENSE.FDL
#ifeq ($(BR2_PACKAGE_QT6BASE_EXAMPLES),y)
#QT6BASE_LICENSE += , BSD-3-Clause (examples)
#endif
#
#QT6BASE_CONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_QT6BASE_CONFIG_FILE))
#
#ifneq ($(QT6BASE_CONFIG_FILE),)
#QT6BASE_CONFIGURE_OPTS += -qconfig buildroot
#endif
#
ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
QT6BASE_CONF_OPTS += -DFEATURE_libudev=ON
QT6BASE_DEPENDENCIES += udev
else
QT6BASE_CONF_OPTS += -DFEATURE_libudev=OFF
endif

# ToDo: FEATURE_cubs only available if FEATURE_gui/FEATURE_widgets enabled???
ifeq ($(BR2_PACKAGE_CUPS), y)
QT6BASE_CONF_OPTS += -DFEATURE_cups=ON
QT6BASE_DEPENDENCIES += cups
else
QT6BASE_CONF_OPTS += -DFEATURE_cups=OFF
endif

# Qt6 SQL Plugins
ifeq ($(BR2_PACKAGE_QT6BASE_SQL),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql=ON
QT6BASE_CONF_OPTS += -DFEATURE_sql_db2=OFF -DFEATURE_sql_ibase=OFF -DFEATURE_sql_oci=OFF -DFEATURE_sql_odbc=OFF
ifeq ($(BR2_PACKAGE_QT6BASE_MYSQL),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_mysql=ON
QT6BASE_DEPENDENCIES += mysql
else
QT6BASE_CONF_OPTS += -DFEATURE_sql_mysql=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_PSQL),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_psql=ON
QT6BASE_DEPENDENCIES += postgresql
else
QT6BASE_CONF_OPTS += -DFEATURE_sql_psql=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_SQLITE_SYSTEM),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_sqlite=ON -DFEATURE_system_sqlite=ON
QT6BASE_DEPENDENCIES += sqlite
else ifeq ($(BR2_PACKAGE_QT6BASE_SQLITE_QT),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_sqlite=ON -DFEATURE_system_sqlite=OFF
else
QT6BASE_CONF_OPTS += -DFEATURE_sql_sqlite=OFF
endif

else # BR2_PACKAGE_QT6BASE_SQL
QT6BASE_CONF_OPTS += -DFEATURE_sql=OFF
endif # BR2_PACKAGE_QT6BASE_SQL

ifeq ($(BR2_PACKAGE_QT6BASE_GUI),y)
QT6BASE_CONF_OPTS += -DFEATURE_gui=ON -DFEATURE_freetype=ON
#QT6BASE_CONF_OPTS += -DFEATURE_opengles2=OFF -DFEATURE_opengles3=OFF -DFEATURE_opengles31=OFF -DFEATURE_opengles32=OFF -DFEATURE_gbm=OFF -DFEATURE_vnc=OFF -DFEATURE_sessionmanager=OFF
QT6BASE_DEPENDENCIES += freetype
QT6BASE_CONF_OPTS += -DFEATURE_vulkan=OFF
else
QT6BASE_CONF_OPTS += -DFEATURE_gui=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_QT6BASE_HARFBUZZ),y)
QT6BASE_CONF_OPTS += -DFEATURE_harfbuzz=ON
ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_4),y)
# system harfbuzz in case __sync for 4 bytes is supported
QT6BASE_CONF_OPTS += -DQT_USE_BUNDLED_BundledHarfbuzz=OFF
QT6BASE_DEPENDENCIES += harfbuzz
else
# qt harfbuzz otherwise (using QAtomic instead)
QT6BASE_CONF_OPTS += -DQT_USE_BUNDLED_BundledHarfbuzz=ON
QT6BASE_LICENSE += , MIT (harfbuzz)
QT6BASE_LICENSE_FILES += src/3rdparty/harfbuzz-ng/COPYING
endif
else
QT6BASE_CONFIGURE_OPTS += -DFEATURE_harfbuzz=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_QT6BASE_WIDGETS),y)
QT6BASE_CONF_OPTS += -DFEATURE_widgets=ON
ifeq ($(BR2_PACKAGE_QT6BASE_LINUXFB),y)
QT6BASE_CONF_OPTS += -DFEATURE_linuxfb=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_linuxfb=OFF
endif
ifeq ($(BR2_PACKAGE_QT6BASE_DIRECTFB),y)
QT6BASE_CONF_OPTS += -DFEATURE_directfb=ON
QT6BASE_DEPENDENCIES += directfb
else
QT6BASE_CONF_OPTS += -DFEATURE_directfb=OFF
endif
ifeq ($(BR2_PACKAGE_QT6BASE_XCB),y)
QT6BASE_CONF_OPTS += \
	-DFEATURE_xcb=ON \
	-DFEATURE_xcb_xlib=ON \
	-DFEATURE_xkbcommon=ON \
	-DFEATURE_xkbcommon_x11=ON
QT6BASE_DEPENDENCIES += \
	libxcb \
	xcb-util-wm \
	xcb-util-image \
	xcb-util-keysyms \
	xcb-util-renderutil \
	xlib_libX11 \
	libxkbcommon
ifeq ($(BR2_PACKAGE_QT6BASE_WIDGETS),y)
QT6BASE_DEPENDENCIES += xlib_libXext
endif
else
QT6BASE_CONF_OPTS += -DFEATURE_xcb=OFF
endif
else
QT6BASE_CONF_OPTS += -DFEATURE_widgets=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_OPENGL_DESKTOP),y)
QT6BASE_CONF_OPTS += -DFEATURE_opengl=ON -DFEATURE_opengl_desktop=ON
QT6BASE_DEPENDENCIES += libgl
else ifeq ($(BR2_PACKAGE_QT6BASE_OPENGL_ES2),y)
QT6BASE_CONF_OPTS += -DFEATURE_opengl=ON -DFEATURE_opengles2=ON
QT6BASE_DEPENDENCIES += libgles
else
QT6BASE_CONF_OPTS += -DFEATURE_opengl=OFF
endif

#QT6BASE_DEFAULT_QPA = $(call qstrip,$(BR2_PACKAGE_QT6BASE_DEFAULT_QPA))
#QT6BASE_CONFIGURE_OPTS += $(if $(QT6BASE_DEFAULT_QPA),-qpa $(QT6BASE_DEFAULT_QPA))

ifeq ($(BR2_PACKAGE_QT6BASE_EGLFS),y)
QT6BASE_CONFIGURE_OPTS += -DFEATURE_eglfs=ON
QT6BASE_DEPENDENCIES += libegl
else
QT6BASE_CONFIGURE_OPTS += -DFEATURE_eglfs=OFF
endif

# ToDo: depend on NETWOK, set FEATURE_openssl_linked, FEATURE_openssl_runtime,
# FEATURE_opensslv11???
ifeq ($(BR2_PACKAGE_OPENSSL),y)
QT6BASE_CONFIGURE_OPTS += -DFEATURE_openssl=ON
QT6BASE_DEPENDENCIES += openssl
else
QT6BASE_CONFIGURE_OPTS += -DFEATURE_openssl=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_FONTCONFIG),y)
QT6BASE_CONF_OPTS += -DFEATURE_fontconfig=ON
QT6BASE_DEPENDENCIES += fontconfig
else
QT6BASE_CONF_OPTS += -DFEATURE_fontconfig=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_QT6BASE_GIF),y)
QT6BASE_CONF_OPTS += -DFEATURE_gif=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_gif=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_QT6BASE_JPEG),y)
QT6BASE_CONF_OPTS += -DFEATURE_jpeg=ON
QT6BASE_DEPENDENCIES += jpeg
else
QT6BASE_CONF_OPTS += -DFEATURE_jpeg=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_QT6BASE_PNG),y)
QT6BASE_CONF_OPTS += -DFEATURE_png=ON -DFEATURE_system_png=ON
QT6BASE_DEPENDENCIES += libpng
else
QT6BASE_CONF_OPTS += -DFEATURE_png=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_DBUS),y)
QT6BASE_CONF_OPTS += -DFEATURE_dbus=ON
QT6BASE_DEPENDENCIES += dbus
HOST_QT6BASE_CONF_OPTS += -DFEATURE_dbus=ON
#HOST_QT6BASE_DEPENDENCIES += host-dbus
else
QT6BASE_CONF_OPTS += -DFEATURE_dbus=OFF
HOST_QT6BASE_CONF_OPTS += -DFEATURE_dbus=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_TSLIB),y)
QT6BASE_CONF_OPTS += -DFEATURE_tslib=ON
QT6BASE_DEPENDENCIES += tslib
else
QT6BASE_CONF_OPTS += -DFEATURE_tslib=OFF
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
QT6BASE_CONF_OPTS += -DFEATURE_glib=ON
QT6BASE_DEPENDENCIES += libglib2
else
QT6BASE_CONF_OPTS += -DFEATURE_glib=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_ICU),y)
QT6BASE_CONF_OPTS += -DFEATURE_icu=ON
QT6BASE_DEPENDENCIES += icu
else
QT6BASE_CONF_OPTS += -DFEATURE_icu=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_EXAMPLES),y)
QT6BASE_CONF_OPTS += -DQT_BUILD_EXAMPLES=ON -DQT_BUILD_EXAMPLES_BY_DEFAULT=ON
else
QT6BASE_CONF_OPTS += -DQT_BUILD_EXAMPLES=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_NETWORK),y)
QT6BASE_CONF_OPTS += -DFEATURE_network=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_network=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_CONCURRENT),y)
QT6BASE_CONF_OPTS += -DFEATURE_concurrent=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_concurrent=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_TEST),y)
QT6BASE_CONF_OPTS += -DFEATURE_testlib=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_testlib=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_XML),y)
QT6BASE_CONF_OPTS += -DFEATURE_xml=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_xml=OFF
endif

# ToDo: FEATURE_kms only available if FEATURE_gui enabled???
ifeq ($(BR2_PACKAGE_LIBINPUT),y)
QT6BASE_CONF_OPTS += -DFEATURE_libinput=ON
QT6BASE_DEPENDENCIES += libinput
else
QT6BASE_CONF_OPTS += -D FEATURE_libinput=OFF
endif

# only enable gtk support if libgtk3 X11 backend is enabled
ifeq ($(BR2_PACKAGE_LIBGTK3)$(BR2_PACKAGE_LIBGTK3_X11),yy)
QT6BASE_CONF_OPTS += -DFEATURE_gtk3=ON
QT6BASE_DEPENDENCIES += libgtk3
else
QT6BASE_CONF_OPTS += -DFEATURE_gtk3=OFF
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
QT6BASE_CONF_OPTS += -DFEATURE_journald=ON
QT6BASE_DEPENDENCIES += systemd
else
QT6BASE_CONF_OPTS += -DFEATURE_journald=OFF
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
QT6BASE_CONF_OPTS += -DFEATURE_zstd=ON
QT6BASE_DEPENDENCIES += zstd
else
QT6BASE_CONF_OPTS += -DFEATURE_zstd=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_SYSLOG),y)
QT6BASE_CONF_OPTS += -DFEATURE_syslog=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_syslog=OFF
endif
#
#ifeq ($(BR2_PACKAGE_IMX_GPU_VIV),y)
## use vivante backend
#QT6BASE_EGLFS_DEVICE = EGLFS_DEVICE_INTEGRATION = eglfs_viv
#else ifeq ($(BR2_PACKAGE_SUNXI_MALI_MAINLINE),y)
## use mali backend
#QT6BASE_EGLFS_DEVICE = EGLFS_DEVICE_INTEGRATION = eglfs_mali
#endif
#
#ifneq ($(QT6BASE_CONFIG_FILE),)
#define QT6BASE_CONFIGURE_CONFIG_FILE
#	cp $(QT6BASE_CONFIG_FILE) $(@D)/src/corelib/global/qconfig-buildroot.h
#endef
#endif
#
#QT6BASE_ARCH_CONFIG_FILE = $(@D)/mkspecs/devices/linux-buildroot-g++/arch.conf
#ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
## Qt 5.8 needs atomics, which on various architectures are in -latomic
#define QT6BASE_CONFIGURE_ARCH_CONFIG
#	printf 'LIBS += -latomic\n' >$(QT6BASE_ARCH_CONFIG_FILE)
#endef
#endif
#
## This allows to use ccache when available
#define QT6BASE_CONFIGURE_HOSTCC
#	$(SED) 's,^QMAKE_CC\s*=.*,QMAKE_CC = $(HOSTCC),' $(@D)/mkspecs/common/g++-base.conf
#	$(SED) 's,^QMAKE_CXX\s*=.*,QMAKE_CXX = $(HOSTCXX),' $(@D)/mkspecs/common/g++-base.conf
#endef

# Must be last so can override all options set by Buildroot
QT6BASE_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_QT6BASE_CUSTOM_CONF_OPTS))

#define QT6BASE_CONFIGURE_CMDS
#	mkdir -p $(@D)/mkspecs/devices/linux-buildroot-g++/
#	sed 's/@EGLFS_DEVICE@/$(QT6BASE_EGLFS_DEVICE)/g' \
#		$(QT6BASE_PKGDIR)/qmake.conf.in > \
#		$(@D)/mkspecs/devices/linux-buildroot-g++/qmake.conf
#	$(INSTALL) -m 0644 -D $(QT6BASE_PKGDIR)/qplatformdefs.h \
#		$(@D)/mkspecs/devices/linux-buildroot-g++/qplatformdefs.h
#	$(QT6BASE_CONFIGURE_CONFIG_FILE)
#	touch $(QT6BASE_ARCH_CONFIG_FILE)
#	$(QT6BASE_CONFIGURE_ARCH_CONFIG)
#	$(QT6BASE_CONFIGURE_HOSTCC)
#	(cd $(@D); \
#		$(TARGET_MAKE_ENV) \
#		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
#		MAKEFLAGS="-j$(PARALLEL_JOBS) $(MAKEFLAGS)" \
#		./configure \
#		-v \
#		-prefix /usr \
#		-hostprefix $(HOST_DIR) \
#		-headerdir /usr/include/qt6 \
#		-sysroot $(STAGING_DIR) \
#		-plugindir /usr/lib/qt/plugins \
#		-examplesdir /usr/lib/qt/examples \
#		-no-rpath \
#		-nomake tests \
#		-device buildroot \
#		-device-option CROSS_COMPILE="$(TARGET_CROSS)" \
#		-device-option BR_COMPILER_CFLAGS="$(QT6BASE_CFLAGS)" \
#		-device-option BR_COMPILER_CXXFLAGS="$(QT6BASE_CXXFLAGS)" \
#		$(QT6BASE_CONFIGURE_OPTS) \
#	)
#endef
#
#QT6BASE_POST_INSTALL_STAGING_HOOKS += QT6_INSTALL_QT_CONF
#

HOST_QT6BASE_DEPENDENCIES = host-pkgconf host-ninja host-zlib
HOST_QT6BASE_MAKE = ninja
HOST_QT6BASE_CONF_OPTS += \
	-GNinja \
	-DCMAKE_DESTDIR=$(HOST_DIR) \
	-DCMAKE_INSTALL_PREFIX=$(HOST_DIR) \
	-DCMAKE_INSTALL_RPATH=$(HOST_DIR)/lib \
	-DBUILD_SHARED_LIBS=OFF \
	-DBUILD_WITH_PCH=OFF \
	-DFEATURE_concurrent=OFF \
	-DFEATURE_glib=OFF \
	-DFEATURE_gui=OFF \
	-DFEATURE_icu=OFF \
	-DFEATURE_network=OFF \
	-DFEATURE_precompile_header=OFF \
	-DFEATURE_system_doubleconversion=ON \
	-DFEATURE_sql=OFF \
	-DFEATURE_system_zlib=ON \
	-DFEATURE_testlib=OFF \
	-DQT_BUILD_BENCHMARKS=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_BUILD_TOOLS_BY_DEFAULT=OFF \
	-DQT_FEATURE_doubleconversion=ON

$(eval $(cmake-package))
$(eval $(host-cmake-package))
