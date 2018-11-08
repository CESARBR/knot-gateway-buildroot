################################################################################
#
# dep
#
################################################################################

GO_DEP_VERSION = v0.5.0
GO_DEP_SITE = $(call github,golang,dep,$(GO_DEP_VERSION))
GO_DEP_LICENSE = Go
GO_DEP_LICENSE_FILES = LICENSE
HOST_GO_DEP_BUILD_TARGETS = cmd/dep
HOST_GO_DEP_BIN_NAME = dep
HOST_GO_DEP_INSTALL_BINS = dep

$(eval $(host-golang-package))
