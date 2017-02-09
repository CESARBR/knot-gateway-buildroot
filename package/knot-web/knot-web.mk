################################################################################
#
#knot-web
#
################################################################################

KNOT_WEB_VERSION = dc6f7285f83c4f4373adaa2dc1a269562389ae81
KNOT_WEB_SITE_METHOD = git
KNOT_WEB_SITE = https://github.com/CESARBR/knot-gateway-webui.git
KNOT_WEB_DEPENDENCIES = nodejs

define KNOT_WEB_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/local/bin/knot-web*
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	cd $(@D) && $(NPM) install
	cp -R $(@D) $(TARGET_DIR)/usr/local/bin/
	$(INSTALL) -D -m 0644 $(@D)/app/config/gatewayConfig.json $(TARGET_DIR)/etc/knot
	$(INSTALL) -D -m 0666 $(@D)/app/config/keys.json $(TARGET_DIR)/etc/knot
	rm -f $(TARGET_DIR)/usr/local/bin/knot-web*/app/config/gatewayConfig.json
	rm -f $(TARGET_DIR)/usr/local/bin/knot-web*/app/config/keys.json
endef

define KNOT_WEB_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_WEB_PKGDIR)/knot-web $(TARGET_DIR)/usr/local/bin/
	$(INSTALL) -D -m 0755 $(KNOT_WEB_PKGDIR)/S65knot-web-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_WEB_POST_INSTALL_TARGET_HOOKS += KNOT_WEB_INSTALL_INIT_SCRIPT

$(eval $(generic-package))
