################################################################################
#
# iwpand
#
################################################################################

IWPAND_VERSION = 7ce266ea573a260e136cec4caff9611c3f9cf5de
IWPAND_SITE = https://github.com/CESARBR/iwpand.git
IWPAND_SITE_METHOD = git
IWPAND_INSTALL_STAGING = NO
IWPAND_INSTALL_TARGET = YES
IWPAND_DEPENDENCIES = host-pkgconf libnl libell
IWPAND_AUTORECONF = YES
IWPAND_TOOLS_AUTORECONF_OPTS = --force --install

define IWPAND_BOOTSTRAP
        cd $(@D) && ./bootstrap
endef

IWPAND_PRE_CONFIGURE_HOOKS += IWPAND_BOOTSTRAP

$(eval $(autotools-package))

