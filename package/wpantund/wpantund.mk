################################################################################
#
# wpantund
#
################################################################################

WPANTUND_VERSION = 47f32126c051ccfaf4c0d974010b2b4c80629c9f
WPANTUND_SITE = https://github.com/openthread/wpantund.git
WPANTUND_SITE_METHOD = git
WPANTUND_INSTALL_STAGING = NO
WPANTUND_INSTALL_TARGET = YES
WPANTUND_DEPENDENCIES = host-autoconf-archive boost
WPANTUND_AUTORECONF = NO
WPANTUND_MAKE = $(MAKE1)
# FIXME: Find a way to put connman-plugin
WPANTUND_CONF_OPTS = --enable-debug --disable-optimization --without-connman \
	--with-readline --enable-ncp-spinel --enable-static-link-ncp-plugin=spinel \
	--sysconfdir=/etc --prefix=/usr
WPANTUND_AUTORECONF_OPTS = -I $(HOST_DIR)/usr/share/autoconf-archive

define WPANTUND_BOOTSTRAP
	cd $(@D) && ./bootstrap.sh && ./configure $(WPANTUND_CONF_OPTS)
endef

#define WPANTUND_AUTORECONF_CMDS
#	cd $(@D) && ./configure $(WPANTUND_CONF_OPTS)
#endef

WPANTUND_PRE_CONFIGURE_HOOKS += WPANTUND_BOOTSTRAP

# TODO: Find a way to select the spi option besides use just usb serial
define WPANTUND_INSTALL_INIT_SCRIPT
	$(SED) '/Config:NCP:SocketPath "\/dev/i Config:NCP:SocketPath "/dev/ttyACM0"' $(TARGET_DIR)/etc/wpantund.conf
	$(INSTALL) -D -m 0755 $(WPANTUND_PKGDIR)/ncp_state_notifier $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -D -m 0755 $(WPANTUND_PKGDIR)/S80wpantund $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 0755 $(@D)/src/wpantund/wpantund $(TARGET_DIR)/usr/local/bin/
endef

WPANTUND_POST_INSTALL_TARGET_HOOKS += WPANTUND_INSTALL_INIT_SCRIPT

$(eval $(autotools-package))
$(eval $(host-autotools-package))
