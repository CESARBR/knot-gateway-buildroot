################################################################################
#
# knot-fog
#
################################################################################

KNOT_FOG_VERSION = master
KNOT_FOG_SITE_METHOD = git
KNOT_FOG_SITE = https://github.com/CESARBR/knot-cloud-source.git
KNOT_FOG_DEPENDENCIES = nodejs

define KNOT_FOG_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/local/bin/knot-fog-source
	mkdir -p $(TARGET_DIR)/usr/local/
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	mkdir -p $(TARGET_DIR)/usr/local/bin/knot-fog-source
	cd $(@D) && $(NPM) install
	cp -R $(@D)/. $(TARGET_DIR)/usr/local/bin/knot-fog-source
	sed -i "/knotInstanceType/c\  knotInstanceType: 'gateway'," $(TARGET_DIR)/usr/local/bin/knot-fog-source/config.js
	sed -i "/databaseUrl: process.env.MONGODB_URI/c\    databaseUrl: process.env.MONGODB_URI || 'mongodb:\/\/localhost:27017\/knot_fog'," $(TARGET_DIR)/usr/local/bin/knot-fog-source/config.js
endef

define KNOT_FOG_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_FOG_PKGDIR)/S60knot-fog-daemon $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 0755 $(KNOT_FOG_PKGDIR)/knot-fog $(TARGET_DIR)/usr/local/bin/
endef

KNOT_FOG_POST_INSTALL_TARGET_HOOKS += KNOT_FOG_INSTALL_INIT_SCRIPT

$(eval $(generic-package))
