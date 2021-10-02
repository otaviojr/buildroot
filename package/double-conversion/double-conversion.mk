################################################################################
#
# double-conversion
#
################################################################################

# use git latest instead of lat release v3.1.5 to enable additioanal
# cpu archs
DOUBLE_CONVERSION_VERSION = 3c6d2c2ec99340bf05aa0fef7842bbaf6af4d830
DOUBLE_CONVERSION_SITE = $(call github,google,double-conversion,$(DOUBLE_CONVERSION_VERSION))
DOUBLE_CONVERSION_LICENSE = BSD-3-Clause
DOUBLE_CONVERSION_LICENSE_FILES = COPYING
DOUBLE_CONVERSION_INSTALL_STAGING = YES

$(eval $(cmake-package))
