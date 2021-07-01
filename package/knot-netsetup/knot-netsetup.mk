################################################################################
#
# knot-netsetup
#
################################################################################

KNOT_NETSETUP_VERSION = KNOT-v03.00-rc04
KNOT_NETSETUP_SITE = https://github.com/CESARBR/knot-gateway-netsetup.git
KNOT_NETSETUP_SITE_METHOD = git
KNOT_NETSETUP_DEPENDENCIES = dbus-python python-daemon python-docutils python-gobject python-lockfile python-setuptools
KNOT_NETSETUP_SETUP_TYPE = setuptools

define KNOT_NETSETUP_INSTALL_INIT_SCRIPT
	ln -fs /usr/bin/netsetup $(TARGET_DIR)/usr/local/bin/netsetup
	$(INSTALL) -D -m 0755 $(KNOT_NETSETUP_PKGDIR)/S85netsetup-daemon $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 0644 $(@D)/netsetup.conf $(TARGET_DIR)/etc/dbus-1/system.d/
endef

KNOT_NETSETUP_POST_INSTALL_TARGET_HOOKS += KNOT_NETSETUP_INSTALL_INIT_SCRIPT

$(eval $(python-package))
