################################################################################
#
# knot-cloud-sdk
#
################################################################################

KNOT_CLOUD_SDK_VERSION = KNOT-v03.00-rc03
KNOT_CLOUD_SDK_SITE = https://github.com/CESARBR/knot-cloud-sdk-c.git
KNOT_CLOUD_SDK_SITE_METHOD = git
KNOT_CLOUD_SDK_INSTALL_STAGING = YES
KNOT_CLOUD_SDK_INSTALL_TARGET = YES
KNOT_CLOUD_SDK_AUTORECONF = YES
KNOT_CLOUD_SDK_DEPENDENCIES = libell json-c rabbitmq-c knot-protocol-lib
KNOT_CLOUD_SDK_CONF_OPTS = --sysconfdir=/etc

ifeq ($(BR2_ENABLE_DEBUG),y)
KNOT_CLOUD_SDK_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_CLOUD_SDK_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_CLOUD_SDK_BOOTSTRAP
	cd $(@D) && ./bootstrap
endef

KNOT_CLOUD_SDK_POST_PATCH_HOOKS += KNOT_CLOUD_SDK_BOOTSTRAP

$(eval $(autotools-package))
