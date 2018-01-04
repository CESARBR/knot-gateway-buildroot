################################################################################
#
# knot-service-app
#
################################################################################

KNOT_SERVICE_APP_VERSION = KNOT-v01.03-rc02
KNOT_SERVICE_APP_SITE = https://github.com/CESARBR/knot-service-source.git
KNOT_SERVICE_APP_SITE_METHOD = git
KNOT_SERVICE_APP_INSTALL_STAGING = NO
KNOT_SERVICE_APP_INSTALL_TARGET = YES
KNOT_SERVICE_APP_DEPENDENCIES = libglib2 json-c libcurl knot-protocol-lib libwebsockets
KNOT_SERVICE_APP_AUTORECONF = YES
KNOT_SERVICE_APP_CONF_OPTS = --prefix=/usr/local --exec-prefix=/usr/local --enable-debug --disable-optimization
KNOT_SERVICE_APP_CONF_ENV = CFLAGS="-I$(@D)/../knot-protocol-lib-KNOT-v01.03-rc02/src -I$(@D)/../knot-hal-driver-KNOT-v01.03-rc02" LIBS="$(@D)/../knot-protocol-lib-KNOT-v01.03-rc02/src/libknotprotocol.a $(@D)/../knot-hal-driver-KNOT-v01.03-rc02/src/hal/log/libhallog.a"

define KNOT_SERVICE_APP_BOOTSTRAP
	cd $(@D) &&  ./bootstrap
endef

KNOT_SERVICE_APP_PRE_CONFIGURE_HOOKS += KNOT_SERVICE_APP_BOOTSTRAP

define KNOT_SERVICE_APP_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_SERVICE_APP_PKGDIR)/S70knotd-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_SERVICE_APP_POST_INSTALL_TARGET_HOOKS += KNOT_SERVICE_APP_INSTALL_INIT_SCRIPT

$(eval $(autotools-package))
