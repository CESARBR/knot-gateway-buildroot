################################################################################
#
# lora-gateway
#
################################################################################

LORA_GATEWAY_VERSION = ddc5e5079ad76c42935f6a5d382194022984f77d
LORA_GATEWAY_SITE_METHOD = git
LORA_GATEWAY_SITE = https://github.com/Lora-net/lora_gateway
LORA_GATEWAY_INSTALL_STAGING = YES
LORA_GATEWAY_INSTALL_TARGET = YES

define LORA_GATEWAY_BUILD_CMDS
	$(MAKE)  CROSS_COMPILE=$(patsubst %-gcc,%-,$(TARGET_CC))  -C $(@D) all
endef

define LORA_GATEWAY_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/include/loragw/inc
	$(INSTALL) -D -m 0644 $(@D)/libloragw/libloragw.a $(STAGING_DIR)/usr/include/loragw/
	$(INSTALL) -D -m 0644 $(@D)/libloragw/library.cfg $(STAGING_DIR)/usr/include/loragw/
	$(INSTALL) -D -m 0644 $(@D)/libloragw/inc/*.h $(STAGING_DIR)/usr/include/loragw/inc/
endef

define LORA_GATEWAY_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/bin/lora-net/gateway/tests
	$(INSTALL) -D -m 0755 $(@D)/*.sh $(TARGET_DIR)/usr/local/bin/lora-net/gateway/
	$(INSTALL) -D -m 0755 $(@D)/libloragw/test_loragw* $(TARGET_DIR)/usr/local/bin/lora-net/gateway/tests/
	$(INSTALL) -d $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils
	$(INSTALL) -D -m 0755 $(@D)/util_lbt_test/util_lbt_test $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_pkt_logger/util_pkt_logger $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
	$(INSTALL) -D -m 0644 $(@D)/util_pkt_logger/*.json $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_spectral_scan/util_spectral_scan $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_spi_stress/util_spi_stress $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_tx_continuous/util_tx_continuous $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_tx_test/util_tx_test $(TARGET_DIR)/usr/local/bin/lora-net/gateway/utils/
endef

$(eval $(generic-package))