################################################################################
#
# knot-fog
#
################################################################################

KNOT_FOG_VERSION = afc145ce8fdc66b820801db6e1fafbe0aff4a765
KNOT_FOG_SITE_METHOD = git
KNOT_FOG_SITE = https://github.com/CESARBR/knot-cloud-source.git
KNOT_FOG_DEPENDENCIES = nodejs

define KNOT_FOG_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/local/bin/knot-fog-source
	mkdir -p $(TARGET_DIR)/usr/local/
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	mkdir -p $(TARGET_DIR)/usr/local/bin/knot-fog-source
	mkdir -p $(TARGET_DIR)/data/db
	cd $(@D) && $(NPM) install
	cp -R $(@D)/* $(TARGET_DIR)/usr/local/bin/knot-fog-source
endef

define KNOT_FOG_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_FOG_PKGDIR)/S55knot-fog-daemon $(TARGET_DIR)/etc/init.d/
	mkdir -p $(TARGET_DIR)/usr/local/
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	$(INSTALL) -D -m 0755 $(KNOT_FOG_PKGDIR)/knot-fog $(TARGET_DIR)/usr/local/bin/
endef

KNOT_FOG_POST_INSTALL_TARGET_HOOKS += KNOT_FOG_INSTALL_INIT_SCRIPT

$(eval $(generic-package))
