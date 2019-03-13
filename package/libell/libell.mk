################################################################################
#
# libell
#
################################################################################

LIBELL_VERSION = 0.17
LIBELL_SITE_METHOD = git
LIBELL_SITE = https://git.kernel.org/pub/scm/libs/ell/ell.git
LIBELL_LICENSE_FILES = COPYING
LIBELL_CFLAGS = $(TARGET_CFLAGS)
LIBELL_AUTORECONF = YES
LIBELL_INSTALL_STAGING = YES
LIBELL_CONF_OPTS = --prefix=/usr

ifeq ($(BR2_STATIC_LIBS),y)
LIBELL_CONF_OPTS += \
	--enable-shared=no \
	--without-libdl
else
LIBELL_CONF_OPTS += --enable-static=no
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
LIBELL_CONF_OPTS += \
	--enable-debug --disable-optimization
else
LIBELL_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

LIBELL_CONF_ENV = \
	CFLAGS="$(LIBELL_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS) -lm"

define LIBELL_BOOTSTRAP
        cd $(@D) && ./bootstrap
endef

LIBELL_PRE_CONFIGURE_HOOKS += LIBELL_BOOTSTRAP
$(eval $(autotools-package))

