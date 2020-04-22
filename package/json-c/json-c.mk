################################################################################
#
# json-c
#
################################################################################

JSON_C_VERSION = json-c-0.14-20200419
JSON_C_SITE = $(call github,json-c,json-c,$(JSON_C_VERSION))
JSON_C_INSTALL_STAGING = YES
JSON_C_LICENSE = MIT
JSON_C_LICENSE_FILES = COPYING

# update config.h.in timestamp to avoid autoheader run
define JSON_C_UPDATE_CONFIG_TIMESTAMP
	touch $(@D)/config.h.in
endef

JSON_C_POST_EXTRACT_HOOKS += JSON_C_UPDATE_CONFIG_TIMESTAMP
HOST_JSON_C_POST_EXTRACT_HOOKS += JSON_C_UPDATE_CONFIG_TIMESTAMP

$(eval $(cmake-package))
