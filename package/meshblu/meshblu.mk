################################################################################
#
# meshblu
#
################################################################################

MESHBLU_VERSION = v1.18.4
MESHBLU_SITE = $(call github,octoblu,meshblu,$(MESHBLU_VERSION))
MESHBLU_DEPENDENCIES = nodejs

define MESHBLU_INSTALL_TARGET_CMDS
        $(NPM) install $(@D)
endef

$(eval $(generic-package))
