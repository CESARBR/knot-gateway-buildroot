################################################################################
#
# knot-protocol-lib
#
################################################################################

KNOT_PROTOCOL_LIB_VERSION = 832f0f270d15edbcbaa732d67b1303d8cbcb06de
KNOT_PROTOCOL_LIB_SITE = https://github.com/CESARBR/knot-protocol-source.git
KNOT_PROTOCOL_LIB_SITE_METHOD = git
KNOT_PROTOCOL_LIB_INSTALL_STAGING = YES
KNOT_PROTOCOL_LIB_INSTALL_TARGET = NO

define KNOT_PROTOCOL_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/src/proto-app/knot_types.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -D -m 0644 $(@D)/src/proto-app/knot_proto_app.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -D -m 0644 $(@D)/src/proto-net/knot_proto_net.h $(STAGING_DIR)/usr/include/
endef

$(eval $(generic-package))
