################################################################################
#
# knot-protocol-lib
#
################################################################################

KNOT_PROTOCOL_LIB_VERSION = KNOT-v02.01-rc02
KNOT_PROTOCOL_LIB_SITE = https://github.com/CESARBR/knot-protocol-source.git
KNOT_PROTOCOL_LIB_SITE_METHOD = git
KNOT_PROTOCOL_LIB_INSTALL_STAGING = YES
KNOT_PROTOCOL_LIB_INSTALL_TARGET = YES
KNOT_SERVICE_APP_AUTORECONF = YES
KNOT_SERVICE_APP_CONF_OPTS = --prefix=/usr/local --exec-prefix=/usr/local --sysconfdir=/etc

ifeq ($(BR2_ENABLE_DEBUG),y)
KNOT_SERVICE_APP_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_SERVICE_APP_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_PROTOCOL_LIB_BOOTSTRAP
	cd $(@D) &&  ./bootstrap 
endef

KNOT_PROTOCOL_LIB_POST_PATCH_HOOKS += KNOT_PROTOCOL_LIB_BOOTSTRAP

$(eval $(autotools-package))
