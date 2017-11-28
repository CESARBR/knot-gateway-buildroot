################################################################################
#
# knot-hal-driver
#
################################################################################

KNOT_HAL_DRIVER_VERSION = aead5bb108c270a8e0ae4d3951c94437641a87ed
KNOT_HAL_DRIVER_SITE = https://github.com/CESARBR/knot-hal-source.git
KNOT_HAL_DRIVER_SITE_METHOD = git
KNOT_HAL_DRIVER_INSTALL_STAGING = NO
KNOT_HAL_DRIVER_INSTALL_TARGET = YES
KNOT_HAL_DRIVER_AUTORECONF = YES
KNOT_HAL_DRIVER_MAKE = $(MAKE1)
ifeq ($(BR2_LINUX_KERNEL_INTREE_DTS_NAME),"bcm2709-rpi-2-b")
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI2_BOARD'
else
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI_BOARD'
endif
KNOT_HAL_DRIVER_DEPENDENCIES = libglib2

define KNOT_HAL_DRIVER_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0644 $(KNOT_HAL_DRIVER_PKGDIR)/S55nrfd-daemon $(TARGET_DIR)/etc/init.d/
endef

KNOT_HAL_DRIVER_POST_INSTALL_TARGET_HOOKS += KNOT_HAL_DRIVER_INSTALL_INIT_SCRIPT

$(eval $(autotools-package))
