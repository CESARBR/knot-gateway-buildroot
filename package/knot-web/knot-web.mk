################################################################################
#
#knot-web
#
################################################################################

KNOT_WEB_VERSION = KNOT-v02.01-rc01
KNOT_WEB_SITE_METHOD = git
KNOT_WEB_SITE = https://github.com/CESARBR/knot-gateway-webui.git
KNOT_WEB_DEPENDENCIES = nodejs avahi

define KNOT_WEB_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/local/bin/knot-web*
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	cd $(@D) && $(NPM) install && $(NPM) run build && $(NPM) prune --production
	cp -R $(@D) $(TARGET_DIR)/usr/local/bin/
endef

define KNOT_WEB_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_WEB_PKGDIR)/knot-web $(TARGET_DIR)/usr/local/bin/
	$(INSTALL) -D -m 0755 $(KNOT_WEB_PKGDIR)/S65knot-web-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_WEB_POST_INSTALL_TARGET_HOOKS += KNOT_WEB_INSTALL_INIT_SCRIPT

define KNOT_WEB_AVAHI_KNOT_SERVICE
	$(INSTALL) -D -m 644 package/knot-web/knot-web.service \
		$(TARGET_DIR)/etc/avahi/services/
endef

KNOT_WEB_POST_INSTALL_TARGET_HOOKS += KNOT_WEB_AVAHI_KNOT_SERVICE

$(eval $(generic-package))
