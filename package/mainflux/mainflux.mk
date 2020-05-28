################################################################################
#
# MAINFLUX
#
################################################################################

MAINFLUX_VERSION = master
MAINFLUX_SITE = $(call github,mainflux,mainflux,$(MAINFLUX_VERSION))
MAINFLUX_LICENSE = Apache-2.0
MAINFLUX_LICENSE_FILES = LICENSE

MAINFLUX_BUILD_TARGETS = cmd/users

define MAINFLUX_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(MAINFLUX_PKGDIR)/S95mainflux-users $(TARGET_DIR)/etc/knot/initS/S95mainflux-users
endef

define MAINFLUX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/mainflux/bin
	cp $(MAINFLUX_PKGDIR)/mainflux.config $(TARGET_DIR)/usr/local/mainflux/
	$(INSTALL) -D -m 0755 $(@D)/bin/users $(TARGET_DIR)/usr/local/mainflux/bin/
endef

MAINFLUX_POST_INSTALL_TARGET_HOOKS += MAINFLUX_INSTALL_INIT_SCRIPT

define MAINFLUX_USERS
	mainflux -1 mainflux -1 * - /bin/sh - mainflux service daemons
endef

$(eval $(golang-package))
