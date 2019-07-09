################################################################################
#
# knot-network-nrf24
#
################################################################################

KNOT_NETWORK_NRF24_VERSION = KNOT-v02.00
KNOT_NETWORK_NRF24_SITE = https://github.com/CESARBR/knot-network-nrf24.git
KNOT_NETWORK_NRF24_SITE_METHOD = git
KNOT_NETWORK_NRF24_INSTALL_STAGING = NO
KNOT_NETWORK_NRF24_INSTALL_TARGET = YES
KNOT_NETWORK_NRF24_DEPENDENCIES = knot-protocol-lib knot-hal-driver libell
KNOT_NETWORK_NRF24_AUTORECONF = YES
KNOT_NETWORK_NRF24_MAKE = $(MAKE1)

KNOT_NETWORK_NRF24_CONF_OPTS = --prefix=/usr/local --exec-prefix=/usr/local

ifeq ($(BR2_STATIC_LIBS),y)
KNOT_NETWORK_NRF24_CONF_OPTS += \
	--enable-share=no
else
KNOT_NETWORK_NRF24_CONF_OPTS += \
	--enable-static=no
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
KNOT_SERVICE_APP_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_SERVICE_APP_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_NETWORK_NRF24_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_NETWORK_NRF24_PKGDIR)/S75nrfd-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_NETWORK_NRF24_POST_INSTALL_TARGET_HOOKS += KNOT_NETWORK_NRF24_INSTALL_INIT_SCRIPT

$(eval $(autotools-package))
