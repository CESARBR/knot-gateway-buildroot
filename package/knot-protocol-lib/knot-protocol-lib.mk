################################################################################
#
# knot-protocol-lib
#
################################################################################

KNOT_PROTOCOL_LIB_VERSION = 66f11aa1aeab9f47a89780cff008b86893496fb4
KNOT_PROTOCOL_LIB_SITE = https://github.com/CESARBR/knot-protocol-source.git
KNOT_PROTOCOL_LIB_SITE_METHOD = git
KNOT_PROTOCOL_LIB_INSTALL_STAGING = YES
KNOT_PROTOCOL_LIB_INSTALL_TARGET = NO
KNOT_SERVICE_APP_AUTORECONF = YES
KNOT_SERVICE_APP_CONF_OPTS = --enable-maintainer-mode --enable-debug --sysconfdir=/etc

define KNOT_PROTOCOL_LIB_BOOTSTRAP
	cd $(@D) &&  ./bootstrap 
endef

KNOT_PROTOCOL_LIB_POST_PATCH_HOOKS += KNOT_PROTOCOL_LIB_BOOTSTRAP

define KNOT_PROTOCOL_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/src/knot_types.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -D -m 0644 $(@D)/src/knot_protocol.h $(STAGING_DIR)/usr/include/
endef

$(eval $(autotools-package))
