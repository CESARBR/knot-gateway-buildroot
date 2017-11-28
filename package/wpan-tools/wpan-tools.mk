################################################################################
#
# wpan-tools
#
################################################################################

WPAN_TOOLS_VERSION = nl802154_llsec
WPAN_TOOLS_SITE = https://github.com/CESARBR/knot-wpan-tools-source.git
WPAN_TOOLS_SITE_METHOD = git
WPAN_TOOLS_DEPENDENCIES = host-pkgconf libnl
WPAN_TOOLS_AUTORECONF = YES
WPAN_TOOLS_AUTORECONF_OPTS = --install --symlink
WPAN_TOOLS_CONF_OPTS = CFLAGS='-O2' --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib
WPAN_TOOLS_LICENSE = ISC
WPAN_TOOLS_LICENSE_FILES = COPYING

WPAN_TOOLS_LIBTOOL_PATCH = NO

$(eval $(autotools-package))
