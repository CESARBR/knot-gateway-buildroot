################################################################################
#
# lora-pkt-forwarder
#
################################################################################

LORA_PKT_FORWARDER_VERSION = fcd256566b466601ced268a31b88d756f2b9dce9
LORA_PKT_FORWARDER_SITE_METHOD = git
LORA_PKT_FORWARDER_SITE = https://github.com/Lora-net/packet_forwarder
LORA_PKT_FORWARDER_INSTALL_STAGING = NO
LORA_PKT_FORWARDER_INSTALL_TARGET = YES
LORA_PKT_FORWARDER_DEPENDENCIES = lora-gateway

define LORA_PKT_FORWARDER_BUILD_CMDS
	$(MAKE)  CROSS_COMPILE=$(patsubst %-gcc,%-,$(TARGET_CC)) LGW_PATH=$(STAGING_DIR)/usr/include/loragw  -C $(@D) all
endef

define LORA_PKT_FORWARDER_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/cfg
	$(INSTALL) -D -m 0755 $(@D)/lora_pkt_fwd/lora_pkt_fwd $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/*.json $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/*.sh $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/cfg/* $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/cfg/
	$(INSTALL) -d $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/utils
	$(INSTALL) -D -m 0755 $(@D)/util_ack/util_ack $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_sink/util_sink $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/utils/
	$(INSTALL) -D -m 0755 $(@D)/util_tx_test/util_tx_test $(TARGET_DIR)/usr/local/bin/lora-net/packet-forwarder/utils/
endef

$(eval $(generic-package))