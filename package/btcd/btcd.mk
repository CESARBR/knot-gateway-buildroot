################################################################################
#
# btcd
#
################################################################################

BTCD_VERSION = 2a560b2036bee5e3679ec2133eb6520b2f195213
BTCD_SITE = $(call github,btcsuite,btcd,$(BTCD_VERSION))
BTCD_LICENSE = ISC
BTCD_LICENSE_FILES = LICENSE
BTCD_GO_GLIDE = YES
BTCD_GO_GET = YES

$(eval $(golang-package))

