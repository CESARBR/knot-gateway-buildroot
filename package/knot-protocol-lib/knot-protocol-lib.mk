################################################################################
#
# knot-protocol-lib
#
################################################################################

KNOT_PROTOCOL_LIB_VERSION = ead9e66e7ba2f4077293d697327ebc33440e34d7
KNOT_PROTOCOL_LIB_SITE = https://github.com/CESARBR/knot-protocol-source.git
KNOT_PROTOCOL_LIB_SITE_METHOD = git
KNOT_PROTOCOL_LIB_INSTALL_STAGING = YES
KNOT_PROTOCOL_LIB_INSTALL_TARGET = YES
KNOT_PROTOCOL_LIB_AUTORECONF = YES

ifeq ($(BR2_ENABLE_DEBUG),y)
KNOT_PROTOCOL_LIB_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_PROTOCOL_LIB_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_PROTOCOL_LIB_BOOTSTRAP
	cd $(@D) && ./bootstrap
endef

KNOT_PROTOCOL_LIB_POST_PATCH_HOOKS += KNOT_PROTOCOL_LIB_BOOTSTRAP

$(eval $(autotools-package))
