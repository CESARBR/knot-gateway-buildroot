KNOT_BABELTOWER_VERSION = KNOT-v03.00-rc04
KNOT_BABELTOWER_SITE = $(call github,cesarbr,knot-babeltower,$(KNOT_BABELTOWER_VERSION))
KNOT_BABELTOWER_LICENSE = Apache-2.0
KNOT_BABELTOWER_LICENSE_FILES = LICENSE

KNOT_BABELTOWER_BUILD_TARGETS = cmd

define KNOT_BABELTOWER_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_BABELTOWER_PKGDIR)/S100knot-babeltower $(TARGET_DIR)/etc/init.d/
endef

define KNOT_BABELTOWER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/babeltower/internal
	cp -R $(@D)/internal $(TARGET_DIR)/usr/local/babeltower
	cp $(KNOT_BABELTOWER_PKGDIR)/babeltower.conf $(TARGET_DIR)/usr/local/babeltower/
	$(INSTALL) -D -m 0755 $(@D)/bin/cmd $(TARGET_DIR)/usr/local/babeltower/babeltower
endef

KNOT_BABELTOWER_POST_INSTALL_TARGET_HOOKS += KNOT_BABELTOWER_INSTALL_INIT_SCRIPT

$(eval $(golang-package))
