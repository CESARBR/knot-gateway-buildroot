################################################################################
#
# libell
#
################################################################################

LIBELL_VERSION = 0.3
LIBELL_SITE = https://git.kernel.org/pub/scm/libs/ell/ell.git
LIBELL_SITE_METHOD = git
LIBELL_AUTORECONF = YES
LIBELL_INSTALL_STAGING = YES
LIBELL_CONF_OPTS = --prefix=/usr

define LIBELL_BOOTSTRAP
        ln -s $(@D) $(@D)/../ell.git && cd $(@D) && ./bootstrap
endef

LIBELL_PRE_CONFIGURE_HOOKS += LIBELL_BOOTSTRAP

$(eval $(autotools-package))

