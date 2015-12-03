################################################################################
#
# knot-hal-driver
#
################################################################################

KNOT_HAL_DRIVER_VERSION = 4feb0086496818f87806b23fda2daa5df252f004
KNOT_HAL_DRIVER_SITE = https://gitlab.cesar.org.br/cesar-iot/knot-hal-source.git
KNOT_HAL_DRIVER_SITE_METHOD = git
KNOT_HAL_DRIVER_INSTALL_STAGING = YES
KNOT_HAL_DRIVER_INSTALL_TARGET = NO
#KNOT_HAL_DRIVER_DEPENDENCIES = libglib2 json-c libcurl knot-protocol-lib
KNOT_HAL_DRIVER_AUTORECONF = YES

$(eval $(autotools-package))
