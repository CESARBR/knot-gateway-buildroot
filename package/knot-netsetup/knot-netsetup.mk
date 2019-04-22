################################################################################
#
# knot-netsetup
#
################################################################################

KNOT_NETSETUP_VERSION = 38d747f445377f45e4a858d9d252282f631372a0
KNOT_NETSETUP_SITE = https://github.com/CESARBR/knot-gateway-netsetup.git
KNOT_NETSETUP_SITE_METHOD = git
KNOT_NETSETUP_SETUP_TYPE = setuptools

define KNOT_NETSETUP_INSTALL_INIT_SCRIPT
	ln -fs /usr/bin/netsetup $(TARGET_DIR)/usr/local/bin/netsetup
	$(INSTALL) -D -m 0755 $(KNOT_NETSETUP_PKGDIR)/S85netsetup-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_NETSETUP_POST_INSTALL_TARGET_HOOKS += KNOT_NETSETUP_INSTALL_INIT_SCRIPT

$(eval $(python-package))
