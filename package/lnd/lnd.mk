################################################################################
#
# lnd
#
################################################################################

LND_VERSION = v0.5-beta
LND_SITE = $(call github,lightningnetwork,lnd,$(LND_VERSION))
LND_LICENSE = MIT
LND_LICENSE_FILES = LICENSE
LND_BUILD_TARGETS =  ../lnd cmd/lncli
LND_INSTALL_BINS =  lnd lncli
LND_GO_DEP = YES

$(eval $(golang-package))

