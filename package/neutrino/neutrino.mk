################################################################################
#
# neutrino
#
################################################################################

NEUTRINO_VERSION = bee0ed11601a4ad0c3b23d462cd71089fc11f2cd
NEUTRINO_SITE = $(call github,lightninglabs,neutrino,$(NEUTRINO_VERSION))
NEUTRINO_LICENSE = MIT
NEUTRINO_LICENSE_FILES = LICENSE
NEUTRINO_GO_GLIDE = YES

$(eval $(golang-package))

