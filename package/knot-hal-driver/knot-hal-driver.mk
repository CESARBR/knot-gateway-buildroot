################################################################################
#
# knot-hal-driver
#
################################################################################

KNOT_HAL_DRIVER_VERSION = 2a56e1a81ebcceaf29932fc5b8f30b08a8e89c22
KNOT_HAL_DRIVER_SITE = https://gitlab.cesar.org.br/cesar-iot/knot-hal-source.git
KNOT_HAL_DRIVER_SITE_METHOD = git
KNOT_HAL_DRIVER_INSTALL_STAGING = YES
KNOT_HAL_DRIVER_INSTALL_TARGET = NO
KNOT_HAL_DRIVER_AUTORECONF = YES
KNOT_HAL_DRIVER_MAKE = $(MAKE1)
ifeq ($(BR2_LINUX_KERNEL_INTREE_DTS_NAME),"bcm2709-rpi-2-b")
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI2_BOARD'
else
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI_BOARD'
endif
KNOT_HAL_DRIVER_DEPENDENCIES = libglib2

$(eval $(autotools-package))
