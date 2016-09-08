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
        cd $(@D) && $(NPM) install -g
endef

define KNOT_FOG_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0644 $(KNOT_FOG_PKGDIR)/S65knot-fog-daemon $(TARGET_DIR)/etc/init.d/
	mkdir $(TARGET_DIR)/usr/local/
	mkdir $(TARGET_DIR)/usr/local/bin/
	$(INSTALL) -D -m 0644 $(KNOT_FOG_PKGDIR)/knot-fog $(TARGET_DIR)/usr/local/bin/
endef

KNOT_FOG_POST_INSTALL_TARGET_HOOKS += KNOT_FOG_INSTALL_INIT_SCRIPT

$(eval $(generic-package))
