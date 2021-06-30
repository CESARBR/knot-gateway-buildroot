################################################################################
#
# MAINFLUX
#
################################################################################

MAINFLUX_VERSION = 0.12.1
MAINFLUX_SITE = $(call github,mainflux,mainflux,$(MAINFLUX_VERSION))
MAINFLUX_LICENSE = Apache-2.0
MAINFLUX_LICENSE_FILES = LICENSE

MAINFLUX_BUILD_TARGETS = cmd/users cmd/things cmd/auth

define MAINFLUX_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(MAINFLUX_PKGDIR)/S95mainflux-users $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 0755 $(MAINFLUX_PKGDIR)/S95mainflux-things $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 0755 $(MAINFLUX_PKGDIR)/S95mainflux-auth $(TARGET_DIR)/etc/init.d/
endef

define MAINFLUX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/mainflux/bin
	cp $(MAINFLUX_PKGDIR)/users.conf $(TARGET_DIR)/usr/local/mainflux/
	cp $(MAINFLUX_PKGDIR)/things.conf $(TARGET_DIR)/usr/local/mainflux/
	cp $(MAINFLUX_PKGDIR)/auth.conf $(TARGET_DIR)/usr/local/mainflux/
	$(INSTALL) -D -m 0755 $(@D)/bin/users $(TARGET_DIR)/usr/local/mainflux/bin/
	$(INSTALL) -D -m 0755 $(@D)/bin/things $(TARGET_DIR)/usr/local/mainflux/bin/
	$(INSTALL) -D -m 0755 $(@D)/bin/auth $(TARGET_DIR)/usr/local/mainflux/bin/
endef

MAINFLUX_POST_INSTALL_TARGET_HOOKS += MAINFLUX_INSTALL_INIT_SCRIPT

define MAINFLUX_USERS
	mainflux -1 mainflux -1 * - /bin/sh - mainflux service daemons
endef

$(eval $(golang-package))
