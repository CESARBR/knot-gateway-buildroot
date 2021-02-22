KNOT_STORAGE_VERSION = KNOT-v03.00-rc03
KNOT_STORAGE_SITE = $(call github,cesarbr,knot-cloud-storage,$(KNOT_STORAGE_VERSION))
KNOT_STORAGE_LICENSE = MIT
KNOT_STORAGE_LICENSE_FILES = LICENSE

KNOT_STORAGE_BUILD_TARGETS = cmd

define KNOT_STORAGE_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_STORAGE_PKGDIR)/S105knot-storage $(TARGET_DIR)/etc/init.d/
endef

define KNOT_STORAGE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/storage/internal
	cp -R $(@D)/internal $(TARGET_DIR)/usr/local/storage
	cp $(KNOT_STORAGE_PKGDIR)/storage.conf $(TARGET_DIR)/usr/local/storage/
	$(INSTALL) -D -m 0755 $(@D)/bin/cmd $(TARGET_DIR)/usr/local/storage/storage
endef

KNOT_STORAGE_POST_INSTALL_TARGET_HOOKS += KNOT_STORAGE_INSTALL_INIT_SCRIPT

$(eval $(golang-package))
