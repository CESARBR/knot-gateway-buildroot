################################################################################
#
# knot-hal-driver
#
################################################################################

KNOT_HAL_DRIVER_VERSION = c4f76d7c1b33b1988322a780af4b56e2751f4c38
KNOT_HAL_DRIVER_SITE = https://gitlab.cesar.org.br/cesar-iot/knot-hal-source.git
KNOT_HAL_DRIVER_SITE_METHOD = git
KNOT_HAL_DRIVER_INSTALL_STAGING = YES
KNOT_HAL_DRIVER_INSTALL_TARGET = NO
KNOT_HAL_DRIVER_AUTORECONF = YES
KNOT_HAL_DRIVER_CONF_OPTS = CFLAGS='-DRASPBERRY'

$(eval $(autotools-package))
