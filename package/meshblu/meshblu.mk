################################################################################
#
# meshblu
#
################################################################################

MESHBLU_VERSION = v1.18.4
MESHBLU_SITE = $(call github,octoblu,meshblu,$(MESHBLU_VERSION))
MESHBLU_DEPENDENCIES = nodejs
#MESHBLU_
#MESHBLU_

define MESHBLU_INSTALL_TARGET_CMDS
        #$(TARGET_MAKE_ENV) PYTHON=$(HOST_DIR)/usr/bin/python2 \
                #$(MAKE) -C $(@D) install \
                #DESTDIR=$(TARGET_DIR) \
                #$(TARGET_CONFIGURE_OPTS) \
                #PATH=$(@D)/bin:$(BR_PATH) \
                #LD="$(TARGET_CXX)"
        $(NPM) install $(@D)
endef

$(eval $(generic-package))
