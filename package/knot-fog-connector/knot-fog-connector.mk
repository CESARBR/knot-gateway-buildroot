################################################################################
#
#knot-fog-connector
#
################################################################################

KNOT_FOG_CONNECTOR_VERSION = KNOT-v03.00-rc04
KNOT_FOG_CONNECTOR_SITE_METHOD = git
KNOT_FOG_CONNECTOR_SITE = https://github.com/CESARBR/knot-fog-connector.git
KNOT_FOG_CONNECTOR_DEPENDENCIES = nodejs

define KNOT_FOG_CONNECTOR_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/local/bin/knot-fog-connector
	mkdir -p $(TARGET_DIR)/usr/local/bin/knot-fog-connector
	cd $(@D) && $(NPM) install && $(NPM) run build && $(NPM) prune --production
	cp -R $(@D)/. $(TARGET_DIR)/usr/local/bin/knot-fog-connector
endef

define KNOT_FOG_CONNECTOR_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_FOG_CONNECTOR_PKGDIR)/knot-connector $(TARGET_DIR)/usr/local/bin/
	$(INSTALL) -D -m 0755 $(KNOT_FOG_CONNECTOR_PKGDIR)/S80knot-fog-connector-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_FOG_CONNECTOR_POST_INSTALL_TARGET_HOOKS += KNOT_FOG_CONNECTOR_INSTALL_INIT_SCRIPT

$(eval $(generic-package))
