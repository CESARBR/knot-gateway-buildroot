################################################################################
#
# knot-hal-driver
#
################################################################################

KNOT_HAL_DRIVER_VERSION = KNOT-v01.04-rc01
KNOT_HAL_DRIVER_SITE = https://github.com/CESARBR/knot-hal-source.git
KNOT_HAL_DRIVER_SITE_METHOD = git
KNOT_HAL_DRIVER_INSTALL_STAGING = YES
KNOT_HAL_DRIVER_INSTALL_TARGET = YES
KNOT_HAL_DRIVER_AUTORECONF = YES
KNOT_HAL_DRIVER_MAKE = $(MAKE1)
ifeq ($(BR2_LINUX_KERNEL_INTREE_DTS_NAME),"bcm2710-rpi-3-b")
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI2_BOARD'
else
ifeq ($(BR2_LINUX_KERNEL_INTREE_DTS_NAME),"bcm2709-rpi-2-b")
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI2_BOARD'
else
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRPI_BOARD'
endif
endif
KNOT_HAL_DRIVER_CONF_OPTS += --prefix=/usr --exec-prefix=/usr
KNOT_HAL_DRIVER_DEPENDENCIES = libglib2

ifeq ($(BR2_ENABLE_DEBUG),y)
KNOT_HAL_DRIVER_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_HAL_DRIVER_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_HAL_DRIVER_BOOTSTRAP
	cd $(@D) &&  ./bootstrap
endef

KNOT_HAL_DRIVER_POST_PATCH_HOOKS += KNOT_HAL_DRIVER_BOOTSTRAP

$(eval $(autotools-package))
