################################################################################
#
# knot-virtualthing
#
################################################################################

KNOT_VIRTUALTHING_VERSION = 9f1f46bfb13a5a614da50f09a2bda416b5d0e656
KNOT_VIRTUALTHING_SITE = https://github.com/CESARBR/knot-virtualthing.git
KNOT_VIRTUALTHING_SITE_METHOD = git
KNOT_VIRTUALTHING_INSTALL_STAGING = NO
KNOT_VIRTUALTHING_INSTALL_TARGET = YES
KNOT_VIRTUALTHING_DEPENDENCIES = libell knot-cloud-sdk knot-protocol-lib \
				libmodbus
KNOT_VIRTUALTHING_AUTORECONF = YES
KNOT_VIRTUALTHING_CONF_OPTS = --prefix=/usr/local --exec-prefix=/usr/local \
			       --sysconfdir=/etc

ifeq ($(BR2_ENABLE_DEBUG),y)
KNOT_VIRTUALTHING_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_VIRTUALTHING_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_VIRTUALTHING_BOOTSTRAP
	cd $(@D) && ./bootstrap
endef

KNOT_VIRTUALTHING_POST_PATCH_HOOKS += KNOT_VIRTUALTHING_BOOTSTRAP

define KNOT_VIRTUALTHING_INSTALL_CONF_FILES
	mkdir -p $(TARGET_DIR)/etc/knot/
	$(INSTALL) -D -m 0644 $(@D)/confs/credentials.conf \
		$(TARGET_DIR)/etc/knot/
	$(INSTALL) -D -m 0644 $(@D)/confs/device.conf $(TARGET_DIR)/etc/knot/
	$(INSTALL) -D -m 0644 $(@D)/confs/cloud.conf $(TARGET_DIR)/etc/knot/
endef

KNOT_VIRTUALTHING_POST_INSTALL_TARGET_HOOKS += \
	KNOT_VIRTUALTHING_INSTALL_CONF_FILES

define KNOT_VIRTUALTHING_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_VIRTUALTHING_PKGDIR)/S65thingd-daemon \
		$(TARGET_DIR)/etc/init.d/
endef

KNOT_VIRTUALTHING_POST_INSTALL_TARGET_HOOKS += \
	KNOT_VIRTUALTHING_INSTALL_INIT_SCRIPT

$(eval $(autotools-package))
