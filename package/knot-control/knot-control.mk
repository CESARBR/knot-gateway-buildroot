################################################################################
#
# knot-control
#
################################################################################

KNOT_CONTROL_VERSION = KNOT-v02.01
KNOT_CONTROL_SITE = https://github.com/CESARBR/knot-gateway-control.git
KNOT_CONTROL_SITE_METHOD = git
KNOT_CONTROL_DEPENDENCIES = python-pika python-pymongo dbus-python python-daemon python-gobject python-lockfile python-setuptools
KNOT_CONTROL_SETUP_TYPE = setuptools

define KNOT_CONTROL_INSTALL_INIT_SCRIPT
	ln -fs /usr/bin/kcontrold $(TARGET_DIR)/usr/local/bin/kcontrold
	$(INSTALL) -D -m 0755 $(KNOT_CONTROL_PKGDIR)/S90kcontrold-daemon $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 0644 $(@D)/control/knot-control.conf $(TARGET_DIR)/etc/dbus-1/system.d/
endef

KNOT_CONTROL_POST_INSTALL_TARGET_HOOKS += KNOT_CONTROL_INSTALL_INIT_SCRIPT

$(eval $(python-package))
